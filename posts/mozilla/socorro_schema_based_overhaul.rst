.. title: Socorro: Schema based overhaul of crash ingestion: retrospective (2022)
.. slug: socorro_schema_based_overhaul
.. date: 2023-01-18 13:00:00 UTC-05:00
.. tags: mozilla, work, socorro, dev, python, story, retrospective

Project
=======

:time: 2+ years
:impact:
    * radically reduced risk of data leaks due to misconfigured permissions
    * centralized and simplified configuration and management of fields
    * normalization and validation performed during processing
    * documentation of data reviews, data caveats, etc
    * reduced risk of bugs when adding new fields--testing is done in CI
    * new crash reporting data dictionary with Markdown-formatted descriptions,
      real examples, relevant links


Summary
=======

I've been working on Socorro (crash ingestion pipeline at Mozilla) since the
beginning of 2016. During that time, I've focused on streamlining maintainence
of the project, paying down technical debt, reducing risk, and improving crash
analysis tooling.

One of the things I identified early on is how the crash ingestion pipeline was
chaotic, difficult to reason about, and difficult to document. What did the
incoming data look like? What did the processed data look like? Was it valid?
Which fields were protected? Which fields were public? How do we add support
for a new crash annotation? This was problematic for our ops staff, engineering
staff, and all the people who used Socorro. It was something in the back of my
mind for a while, but I didn't have any good thoughts.

In 2020, Socorro moved into the Data Org which has multiple data pipelines.
After spending some time looking at how their pipelines work, I wanted to
rework crash ingestion.

The end result of this project is that:

1. the project is easier to maintain:

   * adding support for new crash annotations is done in a couple of schema
     files and possibly a processor rule

2. risk of security issues and data breaches is lower:

   * typos, bugs, and mistakes when adding support for a new crash annotation
     are caught in CI
   * permissions are specified in a central location, changing permission for
     fields is trivial and takes effect in the next deploy, setting permissions
     supports complex data structures in easy-to-reason-about ways, and
     mistakes are caught in CI

3. the data is easier to use and reason about:

   * normalization and validation of crash annotation data happens during
     processing and downstream uses of the data can expect it to be valid;
     further we get a signal when the data isn't valid which can indicate
     product bugs
   * schemas describing incoming and processed data
   * crash reporting data dictionary documenting incoming data fields,
     processed data fields, descriptions, sources, data gotchas, examples, and
     permissions


What is Socorro?
================

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla products like Firefox, Fenix, Thunderbird, and MozillaVPN.

When Firefox crashes, the crash reporter asks the user if the user would like
to send a crash report. If the user answers "yes!", then the crash reporter
collects data related to the crash, generates a crash report, and submits that
crash report as an HTTP POST to Socorro. Socorro saves the submitted crash
report, processes it, and has tools for viewing and analyzing crash data.


State of crash ingestion at the beginning
=========================================

The crash ingestion system was working and it was usable, but it was in a
bad state.


* **Poor data management**

  Normalization and validation of data was all over the codebase and not
  consistent:

  * processor rule code
  * AWS S3 crash storage code
  * Elasticsearch indexing code
  * Telemetry crash storage code
  * Super Search querying and result rendering code
  * report view and template code
  * signature report code and template code
  * crontabber job code
  * any scripts that used the data
  * tests -- many of which had bad test data so who knows what they were really
    testing

  Naive handling of minidump stackwalker output which meant that any changes in
  the stackwalker output were predominantly unnoticed and there was no indication
  as to whether changed output created issues in the system.

  Further, since it was all over the place, there were no guarantees for data
  validity when downloading it using the RawCrash, ProcessedCrash, and
  SuperSearch APIs. Anyone writing downstream systems would also have to
  normalize and validate the data.

* **Poor permissions management**

  Permissions were defined in multiple places:

  * Elasticsearch json redactor
  * Super Search fields
  * RawCrash API allow list
  * ProcessedCrash API allow list
  * report view and template code
  * Telemetry crash storage code
  * and other places

  We couldn't effectively manage permissions of fields in the stackwalker output
  because we had no idea what was there.

* **Poor documentation**

  No documentation of crash annotation fields other than `CrashAnnotations.yaml
  <https://hg.mozilla.org/mozilla-central/raw-file/tip/toolkit/crashreporter/CrashAnnotations.yaml>`__
  which didn't enforce anything in crash ingestion (process, valid type, data
  correctness, etc) and was missing important information like data gotchas,
  data review urls, and examples.

  No documentation of processed crash fields at all.

* **Making changes was high risk**

  Changing fields from public to protected was high risk because you had to
  find all the places it might show up which was intractable. Adding support
  for new fields often took multiple passes over several weeks because we'd
  miss things. Server errors happend with some regularity due to weirdness with
  crash annotation values affecting the Crash Stats site.

* **Tangled concerns across the codebase**

  Lots of tangled concerns where things defined in one place affected other
  places that shouldn't be related. For example, the Super Search fields
  definition was acting as a "schema" for other parts of the system that had
  nothing to do with Elasticsearch or Super Search.

* **Difficult to maintain**

  It was difficult to support new products.

  It was difficult to debug issues in crash ingestion and crash reporting.

  The Crash Stats webapp contained lots of if/then/else bits to handle
  weirdness in the crash annotation values. Nulls, incorrect types, different
  structures, etc.

  Socorro contained lots of vestigial code from half-done field removal,
  deprecated fields, fields that were removed from crash reports, etc. These
  vestigial bits were all over the code base. Discovering and removing these
  bits was time consuming and error prone.

  The code for exporting data to Telemetry built the export data using a list
  of fields to *exclude* rather than a list of fields to *include*. This is
  backwards and impossible to maintain--we never should have been doing this.
  Further, it pulled data from the raw crash which we had no validation
  guarantees for which would cause issues downstream in the Telemetry import
  code.

  There was no way to validate the data used in the unit tests which meant that
  a lot of it was invalid. We had no way to validate the test data which meant
  that CI would pass, but we'd see errors in our stage and production
  environments.

* **Different from other similar systems**

  In 2020, Socorro was moved to the Data Org in Mozilla which had a set of
  standards and conventions for collecting, storing, analyzing, and providing
  access to data. Socorro didn't follow any of it which made it difficult to
  work on, to connect with, and to staff. Things Data Org has that Socorro
  didn't:

  * a schema covering specifying fields, types, and documentation
  * data flow documentation
  * data review policy, process, and artifacts for data being collected and
    how to add new data
  * data dictionary for fields for users including documentation, data review
    urls, data gotchas


In summary, we had a system that took a lot of effort to maintain, wasn't
serving our users' needs, and was high risk of security/data breach.


Project plan
============

Many of these issues can be alleviated and reduced by moving to a
schema-driven system where we:

1. define a schema for annotations and a schema for the processed crash
2. change crash ingestion and the Crash Stats site to use those schemas

When designing this schema-driven system, we should be thinking about:

1. how easy is it to maintain the system?
2. how easy is it to explain?
3. how flexible is it for solving other kinds of problems in the future?
4. what kinds of errors will likely happen when maintaining the system and how
   can we avert them in CI?
5. what kinds of errors can happen and how much risk do they pose for data
   leaks? what of those can we avert in CI?
6. how flexible is the system which needs to support multiple products
   potentially with different needs?

I worked out a minimal version of that vision that we could migrate to and then
work with going forward.

The crash annotations schema should define:

1. what annotations are in the crash report?
2. which permissions are required to view a field
3. field documentation (provenance, description, data review, related bugs,
   gotchas, analysis tips, etc)

The processed crash schema should define:

1. what's in the processed crash?
2. which permissions are required to view a field
3. field documentation (provenance, description, related bugs, gotchas,
   analysis tips, etc)

Then we make the following changes to the system:

1. write a processor rule to copy, nomralize, and validate data from
   the raw crash based on the processed crash schema
2. switch the Telemetry export code to using the processed crash for
   data to export
3. switch the Telemetry export code to using the processed crash schema
   for permissions
4. switch Super Search to using the processed crash for data to index
5. switch Super Search to using the processed crash schema for documentation
   and permissions
6. switch Crash Stats site to using the processed crash for data to render
7. switch Crash Stats site to using the processed crash schema for
   documentation and permissions
8. switch the RawCrash, ProcessedCrash, and SuperSearch APIs to using the crash
   annotations and processed crash schemas for documentation and permissions

After doing that, we have:

1. field documentation is managed in the schemas
2. permissions are managed in the schemas
3. data is normalized and validated once in the processor and everything
   uses the processed crash data for indexing, searching, and rendering
4. adding support for new fields and changing existing fields is easier and
   problems are caught in CI


Implementation decisions
========================

**Use JSON Schema.**

Data Org at Mozilla uses JSON Schema for schema specification. The schema is
written using YAML.

https://mozilla.github.io/glean_parser/metrics-yaml.html

The metrics schema is used to define ``metrics.yaml`` files which specify the
metrics being emitted and collected.

For example:

https://searchfox.org/mozilla-central/source/toolkit/mozapps/update/metrics.yaml

One long long long term goal for Socorro is to unify standards and practices
with the Data Ingestion system. Towards that goal, it's prudent to build out a
crash annotation and processed crash schemas using whatever we can take from
the equivalent metrics schemas.

We'll additionally need to build out tooling for verifying, validating, and
testing schema modifications to make ongoing maintenance easier.


**Use schemas to define and drive everything.**

We've got permissions, structures, normalization, validation, definition,
documentation, and several other things related to the data and how it's used
throughout crash ingestion spread out across the codebase.

Instead of that, let's pull it all together into a single schema and change the
system to be driven from this schema.

The schema will include:

1. structure specification
2. documentation including data gotchas, examples, and implementation details
3. permissions
4. processing instructions

We'll have a schema for supported annotations and a schema for the processed
crash.

We'll rewrite existing parts of crash ingestion to use the schema:

1. processing

   1. use processing instructions to validate and normalize annotation data

2. super search

   1. field documentation
   2. permissions
   3. remove all the normalization and validation code from indexing

3. crash stats

   1. field documentation
   2. permissions
   3. remove all the normalization and validation code from page rendering


**Only use processed crash data for indexing and analysis.**

The indexing system has its own normalization and validation code since it
pulls data to be indexed from the raw crash.

The crash stats code has its own normalization and validation code since it
renders data from the raw crash in various parts of the site.

We're going to change this so that all normalization and validation happens
during processing, the results are stored in the processed crash, and indexing,
searching, and crash analysis only work on processed crash data.


**By default, all data is protected.**

By default, all data is protected unless it is *explicitly* marked as public.
This has some consequences for the code:

1. any data not specified in a schema is treated as protected
2. all schema fields need to specify permissions for that field
3. any data in a schema is either:

   * marked public, OR
   * lists the permissions required to view that data

4. for nested structures, any child field that is public has public ancesters

We can catch some of these issues in CI and need to write tests to verify them.

This is slightly awkward when maintaining the schema because it would be more
reasonable to have "no permissions required" mean that the field is public.
However, it's possible to accidentally not specify the permissions and we don't
want to be in that situation. Thus, we decided to go with explicitly marking
public fields as public.


Work done
=========

Phase 1: cleaning up
--------------------

We had a lot of work to do before we could start defining schemas and changing
the system to use those schemas.

1. remove vestigial code (some of this work was done in other phases as it was
   discovered)

   * :bz:`1724933`: remove unused/obsolete annotations (2021-08)
   * :bz:`1743487`: remove ``total_frames`` (2021-11)
   * :bz:`1743704`: remove jit crash classifier (2022-02)
   * :bz:`1762000`: remove vestigial ``Winsock_LSP`` code (2022-03)
   * :bz:`1784485`: remove vestigial ``exploitability`` code (2022-08)
   * :bz:`1784095`: remove vestigial ``contains_memory_report`` code (2022-08)
   * :bz:`1787933`: exorcise flash things from the codebase (2022-09)

2. fix signature generation

   * :bz:`1753521`: use fields from processed crash (2022-02)
   * :bz:`1755523`: fix signature generation so it only uses processed crash data (2022-02)
   * :bz:`1762207`: remove ``hang_type`` (2022-04)

3. fix Super Search 

   * :bz:`1624345`: stop saving random data to Elasticsearch crashstorage (2020-06)
   * :bz:`1706076`: remove dead Super Search fields (2021-04)
   * :bz:`1712055`: remove ``system_error`` from Super Search fields (2021-07)
   * :bz:`1712085`: remove obsolete Super Search fields (2021-08)
   * :bz:`1697051`: add ``crash_report_keys`` field (2021-11)
   * :bz:`1736928`: remove ``largest_free_vm_block`` and ``tiny_block_size`` (2021-11)
   * :bz:`1754874`: remove unused annotations from Super Search (2022-02)
   * :bz:`1753521`: stop indexing items from raw crash (2022-02)
   * :bz:`1762005`: migrate to lower-cased versions of ``Plugin*`` fields in
     processed crash (2022-03)
   * :bz:`1755528`: fix flag/boolean handling (2022-03)
   * :bz:`1762207`: remove ``hang_type`` (2022-04)
   * :bz:`1763264`: clean up super search fields from migration (2022-07)

4. fix data flow and usage

   * :bz:`1740397`: rewrite ``CrashingThreadInfoRule`` to normalize crashing thread (2021-11)
   * :bz:`1755095`: fix ``TelemetryBotoS3CrashStorage`` so it doesn't use Super Search fields (2022-03)
   * :bz:`1740397`: change webapp to pull ``crashing_thread`` from processed crash (2022-07)
   * :bz:`1710725`: stop using ``DotDict`` for raw and processed data (2022-09)

5. clean up the raw crash structure

   * :bz:`1687987`: restructure raw crash (2021-01 through 2022-10)


Phase 2: define schemas and all the tooling we needed to work with them
-----------------------------------------------------------------------

After cleaning up the code base, removing vestigial code, fixing Super Search,
and fixing Telemetry export code, we could move on to defining schemas and
writing all the code we needed to maintain the schemas and work with them.

* :bz:`1762271`: rewrite json schema reducer (2022-03)
* :bz:`1764395`: schema for processed crash, reducers, traversers (2022-08)
* :bz:`1788533`: fix ``validate_processed_crash`` to handle
  ``pattern_properties`` (2022-08)
* :bz:`1626698`: schema for crash annotations in crash reports (2022-11)


Phase 3: fix everything to use the schemas
------------------------------------------

That allowed us to fix a bunch of things:

* :bz:`1784927`: remove elasticsearch redactor code (2022-08)
* :bz:`1746630`: support new ``threads.N.frames.N.unloaded_modules``
  minidump-stackwalk fields (2022-08)
* :bz:`1697001`: get rid of UnredactedCrash API and model (2022-08)
* :bz:`1100352`: remove hard-coded allow lists from RawCrash  (2022-08)
* :bz:`1787929`: rewrite ``Breadcrumbs`` validation (2022-09)
* :bz:`1787931`: fix Super Search fields to pull permissions from processed
  crash schema (2022-09)
* :bz:`1787937`: fix Super Search fields to pull documentation from processed
  crash schema (2022-09)
* :bz:`1787931`: use processed crash schema permissions for super search (2022-09)
* :bz:`1100352`: remove hard-coded allow lists from ProcessedCrash models (2022-11)
* :bz:`1792255`: add telemetry_environment to processed crash (2022-11)
* :bz:`1784558`: add collector metadata to processed crash (2022-11)
* :bz:`1787932`: add data review urls for crash annotations that have data reviews (2022-11)


Phase 4: improve
----------------

With fields specified in schemas, we can write a crash reporting data
dictionary:

* :bz:`1803558`: crash reporting data dictionary (2023-01)
* :bz:`1795700`: document raw and processed schemas and how to maintain them
  (2023-01)

Then we can finish:

* :bz:`1677143`: documenting analysis gotchas (ongoing)
* :bz:`1755525`: fixing the report view to only use the processed crash (future)
* :bz:`1795699`: validate test data (future)


Random thoughts
===============

This was a very very long-term project with many small steps and some really
big ones. Getting large projects done is futile and the only way to do it
successfully is to break it into a million small steps each of which stand on
their own and don't create urgency for getting the next step done.

Any time I changed field names or types, I'd have to do a data migration. Data
migrations take 6 months to do because I have to wait for existing data to
expire from storage. On the one hand, it's a blessing I could do migrations at
all--you can't do this with larger data sets or with data sets where the data
doesn't expire without each migration becoming a huge project. On the other
hand, it's hard to juggle being in the middle of multiple migrations and
sometimes the contortions one has to perform are grueling.

If you're working on a big project that's going to require changing data
structures, figure out how to do migrations early with as little work as
possible and use that process as often as you can.


Conclusion and where we could go from here
==========================================

This was such a huge project that spanned years. It's so hard to finish
projects like this because the landscape for the project is constantly
changing. Meanwhile, being mid-project has its own set of complexities and
hardships.

I'm glad I tackled it and I'm glad it's mostly done. There are some minor
things to do, still, but this new schema-driven system has a lot going for it.
Adding support for new crash annotations is much easier, less risky, and takes
less time.

It took me about a month to pull this post together.


That's it!
==========

That's the story of the schema-based overhaul of crash ingestion. There's
probably some bits missing and/or wrong, but the gist of it is here.

If you have any questions or bump into bugs, I hang out on ``#crashreporting`` on
``chat.mozilla.org``. You can also write up a `bug for Socorro
<https://bugzilla.mozilla.org/enter_bug.cgi?format=__standard__&product=Socorro>`_.

Hopefully this helps. If not, let us know!
