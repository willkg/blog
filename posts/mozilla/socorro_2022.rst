.. title: Socorro Engineering: 2022 retrospective
.. slug: socorro_2022
.. date: 2023-01-23 16:00:00 UTC-05:00
.. tags: mozilla, work, socorro, tecken, dev
.. type: text

Summary
=======

2022 took forever. At the same time, it kind of flew by. 2023 is already moving
along, so this post is a month late. Here's the retrospective of Socorro
engineering in 2022.

.. TEASER_END


Highlights of 2022
==================

This is long because 2022 was busy busy busy. I didn't spend much time going
through my engineering journal for things I missed, so there's probably stuff I
missed.

* **Found a bug in Fenix crash reporter that had eluded us for a long while**

  When I rewrote the collector's payload parsing, we started seeing weird
  errors with crash reports reported by Fenix. I looked into that and
  discovered a minor bug in the Fenix crash reporter code that had been there
  for a while.

  * bug: :bz:`1757854`
  * bug: `android components issue #11809 <https://github.com/mozilla-mobile/android-components/issues/11809>`__

* **Fix telemetry marionette test cases**

  This was at the beginning of 2022. If I recall, there were two problems.

  The first is that ``minidump_stackwalk`` needed an additional flag, otherwise
  it wouldn't download symbols and then when the telemetry marionette tests
  crashed, the stacks would be unsymbolicated--but only on Windows. I found and
  fixed that.

  * bug: :bz:`1594515`

  After I fixed that, Aria replaced that stackwalker with the new rust-minidump
  one which was infinitely better in a million ways.

  Then I wanted to verify that when the Telemetry marionette tests crashed and
  there were symbols on disk, whether the stackwalker would use the symbols on
  disk instead of pulling them from symbols.mozilla.org. After a series of try
  pushes verifying the different possibilities, I was able to verify it was
  using the symbols on disk and I closed out the bug.

  * bug: :bz:`1746747`

* **Socorro/Tecken overview**

  I did a "Socorro/Tecken Overview 2022" presentation. I then wrote a script to
  export the slides into images and converted the whole thing to a blog post.

  * Blog post: :doc:`socorro_tecken_overview_2022`

* **Migrate from Mozilla on-prem Sentry to hosted Sentry**

  From what I understand, for other projects at Mozilla, migrating to hosted
  Sentry was straight-forward and it consisted of changing the ``sentry_dsn``
  somewhere--no big deal.

  For Socorro and Tecken, it was a long project and consisted of a bunch of
  steps:

  1. Audited Sentry usage in Socorro and Tecken.

     In Socorro, we had these using Sentry: collector, processor, processor disk
     cache manager, js in the webapp, webapp, crontabber scheduled task runner,
     and migration deploy script.

     In Tecken, we had these using Sentry: webapp, js in the webapp, migration
     deploy script, celery, symbolication webapp, and symbolication disk cache
     manager.

     In total, this involved auditing Sentry usage across 13 things.
  2. Remove Sentry client usage from parts of Socorro and Tecken that weren't
     really using them.
  3. Migrated Socorro and Tecken services that were still using the old,
     deprecated Raven Python client to the new sentry-sdk client.

     * Had to read through the Sentry integration code. Socorro and Tecken
       are composed of 13 things that use Sentry all of which pick up different
       integrations by default. I had to figure out which integrations to use
       and which to not use because they violated our data policy restrictions.

     * Had to implement Sentry event filtering. Since I have like 6 services
       across 3 repositories for 2 projects, it was better to do this as a
       library. Thus was born `fillmore <https://fillmore.readthedocs.io>`__.

       Fillmore makes it possible to filter Sentry events, test filtering, and
       verify that events aren't changing as you update sentry-sdk or other
       libraries.

     * Had to implement a fake sentry service I could run with docker-compose.
       Since I have 3 repositories across 2 projects, it was better to do this
       as a library. Thus was born `kent <https://github.com/willkg/kent/>`__.

       Kent makes it possible to see what's getting sent in Sentry event
       payloads, test filtering, and build automated integration tests.

  4. Since Socorro holds `category 4 data
     <https://wiki.mozilla.org/Data_Collection>`__ and we were now sending
     exception data to a third-party, I had to do a security-focused audit and
     an RRA to make sure what Socorro could send was safe to send and that we
     had all the infrastructure we needed to ensure nothing changed in the
     future.

  It was a lot of work. Some of it was done at the end of 2021 and the rest in
  2022.

  * Socorro bug: :bz:`1812325` (backfilled to collect all the work)
  * Tecken bug: :bz:`1812330` (backfilled to collect all the work)
  * Fillmore: `<https://fillmore.readthedocs.io/>`__
  * Kent: `<https://github.com/willkg/kent/>`__
  * Blog post: :doc:`kent_0_1_0`.

* **Ran a Volunteer Responsibility Amnesty Day for Data Org**

  I learned about `Volunteer Responsibility Amnesty Day
  <https://www.volunteeramnestyday.net/>`__ where you take some time to take
  stock of all the open source things you're doing and which commitments you
  need to change or end. One of the goals we had in Data Org was to "land
  planes" and reduce maintenance burden. I wondered if Volunteer Responsibility
  Amnesty Day could be a helpful exercise towards that goal.

  Ultimately, I don't know how much it *really* helped, but it was worth doing
  and thinking about and maybe it's a tool we can use more effectively some
  day.

  * Blog post: :doc:`volunteer_responsibility_amnesty_day_2022_06`

* **Redid how the stackwalker gets into Socorro Docker images**

  Originally, Socorro built the stackwalker when building the Docker image. That
  took a lot of time and the stackwalker doesn't change often. I split the
  stackwalker building out to another project that generates an artifact when
  we update it and then changed the Socorro Docker image building to use
  that artifact. This dropped the build time from 22 minutes to 7.

  * Bug: :bz:`1759065`

* **Offloaded/ended/deprecated a bunch of projects**

  * I ended the `Puente <https://github.com/mozilla/puente/>`__ project.

  * I passed `Dennis <https://github.com/mozilla/dennis/>`__ off to new
    maintainers. Blog post: :doc:`dennis_1_0_0`

  * I ended `github-bugzilla-pr-linker
    <https://github.com/mozilla/github-bugzilla-pr-linker/>`__.

  * I planned to deprecate `Bleach <https://github.com/mozilla/bleach/>`__, but
    didn't finish that work until today. Blog post: :doc:`bleach_6_0_0_deprecation`

  Each one of these involved auditing the project and figuring out:

  * who used the project
  * what state the project was in
  * what alternatives existed and possible migration options

  Then I shopped those audits around to stakeholders and other people who might
  have opinions on the future direction for the project.

  Ending projects takes more energy than continuing to maintain them.

* **Schema-driven overhaul of crash ingestion**

  For a while, I've been slogging through converting Socorro into a
  schema-driven system. In 2022, I finally finished it.

  Adding support for new annotations takes an hour for most annotations. Making
  the changes is straight-forward. Testing them is also straight-forward.
  There's a lot of tooling and validation tests to make sure everything is
  correct. I can make changes with confidence. I can't understate how fantastic
  this is.

  Also, I was able to throw together a crash ingestion data dictionary in 4
  hours.

  When people ask questions on ``#crashreporting``, I can more easily point
  them to documentation on specific fields and what the values look like.

  It was a lot of work, but Socorro is easier to maintain now.

  * Blog post: :doc:`socorro_schema_based_overhaul`

* **Unloaded module support**

  Just after we switched from `minidump-stackwalk
  <https://github.com/mozilla-services/minidump-stackwalk>`__ to the
  `rust-minidump stackwalker
  <https://github.com/rust-minidump/rust-minidump/tree/main/minidump-stackwalk>`__,
  Aria added support for listing unloaded module information.
  I did the minimum I could do to support that until I had finished up
  the processed crash schema of the schema-driven overhaul.

  Once I had a processed crash schema, I:

  * added the relevant fields to the processed crash schema
  * added support for the unloaded module information to the report view
  * added support for unloaded modules to signature generation

  This was a big improvement for crash analysis.

  * Bug: :bz:`1746630`
  * Bug: :bz:`1797742`

* **Inline function support**

  In July 2023, Markus took on implementing support for inline function data
  in crash reporting. He did a ton of work across a bunch of project. However,
  all that work was blocked by me adding support to Tecken (symbolication) and
  Socorro (stackwalker, report view, signature generation, etc).

  Once I finished up the processed crash schema part of the schema-driven
  overhaul, I tackled reviewing, verifying, and landing all of Markus' changes:

  * update the stackwalker to 0.14.0 (:bz:`1779630`)
  * the processed crash schema (:bz:`1788267`)
  * the crashing thread stack in the report view (:bz:`1788103`)
  * signature generation (:bz:`1788269`)
  * the top 10 frames of the stack in create-a-bug bugzilla links (:bz:`1791271`)
  * fix "top most filenames" to include inline function data (:bz:`1800141`)

  Then Gabriele, Markus, Jeff, and others tweaked signature generation to
  account for inline function data. That work is still ongoing.

  The other thing that happened is that the size of sym files ballooned. I knew
  they were going to grow in size, but I wasn't paying enough attention to the
  conversations in July (I might have been on PTO--I forget what happened) and
  didn't realize just how much they were growing.

  I spent the bulk of 2022q4 dealing with service degradation issues around the
  sym file size changes.

  * **Sym files had increased dramatically**

    I knew that sym files had increased in size, but I didn't understand the
    magnitude. We have limited data available and I can't look at the sym files
    directly (easily), so it took me a while to figure out how to measure what
    I needed to measure to see what we were looking at.

    The end result was a Jupyter notebook.

    https://github.com/willkg/socorro-jupyter/blob/main/notebooks/bug_1796120_sym_sizes.ipynb

    The summary is that the size of the xul module sym files had increased by
    500-600mb. Yipes.

    * Bug: :bz:`1796120`

  * **Mozilla Symbols Server nodes monotonically use disk space and die**

    The size of the ``symbols.zip`` file had increased so much that when the
    Firefox build system went to upload the ``symbols.zip`` file, it took so
    long it triggered a timeout in the Gunicorn worker causing Gunicorn to kill
    the worker off leaving whatever data the worker was working on on disk.
    Since there's nothing to clean up the data on disk and the Firefox build
    system would try again, eventually the disk for an instance would fill up
    and then the instance would die.

    * Bug: :bz:`1790808`

  * **Mozilla Symbolication Server ran out of memory**

    Symbolication involves downloading sym files from the Mozilla Symbols
    Server, parsing them converting them to symcache files, and then doing
    address lookups in those files to get the frame symbols. The sym files
    had increased dramatically in size.

    Having multiple workers download, parsing, and looking up addresses in
    sym files meant we had a bunch of sym files in memory at the same time.
    Because the stacks we're symbolicating are all stacks for Firefox or Fenix
    or other Mozilla products, they almost always had a xul module involved.
    And just like that, we were running out of memory and the Eliot instances
    were crashing.

    We fixed this in a few ways, but the big changes were that we reduced the
    number of workers on an instance and I rewrote symbolication so that it
    reordered the symbols to look up so that a worker only had one the sym file
    for a single module in memory at any given time.

    * Bug: :bz:`1793984`

  * **SymCacheErrorBadDebugFile**

    There was a bug in ``dump_syms`` where the ``INLINE_ORIGIN`` line had an
    address, but no symbol. We were getting a lot of errors. I wrote some
    new tooling to help figure out what was going on. Gabriele wrote
    up an issue and fixed it. Then we had to figure out what to do with the
    errant sym files. I decided to fix them manually since there were tens of
    them and once fixed, a sym file wouldn't be problematic anymore. I wrote
    tooling to do that.

    I wrote up `issue 487 <https://github.com/mozilla/dump_syms/issues/487>`__
    to include an ``INFO`` line to the sym file that indicated what version of
    ``dump_syms`` generated it.

    While manually fixing sym files, I noticed that I was seeing ones with this
    new ``INFO`` line. Then we discovered a second issue with ``dump_syms``
    where symbols had naughty characters like newlines in them which caused
    them to get split across lines. I noticed this and wrote up `issue 511
    <https://github.com/mozilla/dump_syms/issues/511>`__ which Markus fixed.

    I'm still fixing the occasional bad sym file.

    * Bug: :bz:`1794095`

  * **Numeric 2,644,960,066 out of range**

    The ``symbols.zip`` files were so big that when Tecken went to record the
    size in the ``upload_upload.size`` field, it exceeded the maximum for that
    field type.

    We had to do a database migration to fix the type and allow the larger
    values.

    Oh, but we hadn't done a database migration in a long time, so we had to
    dust off all the migration code. Also, this was on a big table, so I had to
    coordinate with SRE and do an outage window to run the migration.

    * Bug: :bz:`1796264`

  * **Processor lag causes queue build up**

    After we landed all the inline function data code, the processors started
    taking longer to process crash reports because they were spending more time
    downloading sym files, saving sym files to disk, and loading files from
    disk. Also, the processor is a single Python process that runs multi-threaded.

    My theory is that the increased size means the processor is spending more
    time downloading sym files from symbols.mozilla.org and since it's
    multi-threaded, it's spending a lot more time in io_wait and only using a
    single VCPU. That'd be fine, except they were taking longer and spending
    more time in io_wait and the average CPU usage dropped and then our scaling
    triggers didn't work so the processor cluster stopped scaling up under
    load.

    This took a long time to sort out and while I have a theory, I haven't had
    a chance to address it, yet. We've worked around the issue by increasing
    the minimum number of processor instances.

    I'm hoping to fix this in 2023.

    * Bug: :bz:`1795017`

  It's wild because Socorro and Tecken have largely been stable for years.
  Increasing the sym file size tipped the boat over and with the skeleton crew
  we have, it took a lot of calendar days to stabilize things.

  But now we've got better infrastructure dashboards, I have a bunch of new
  tools for analysis, the code is emitting some new helpful metrics, and I
  rewrote a bunch of code that was due for fixing.

  This was a big improvement for crash analysis.

* **Helped with a sphinx-js release unblocking Python 3.10 support for Firefox engineering**

  `sphinx-js <https://github.com/mozilla/sphinx-js>`__ is a Sphinx extension
  used to build the Firefox source docs. It hadn't really been actively
  maintained in a while.

  I helped Lonnen sort out the issues preventing it from working in Python 3.10
  and Sphinx 4.1.0+.

  * `sphinx-js issue #209 <https://github.com/mozilla/sphinx-js/issues/209>`__
  * `sphinx-js PR #210 <https://github.com/mozilla/sphinx-js/pull/210>`__
  * `Sphinx issue #11021 <https://github.com/sphinx-doc/sphinx/issues/11021>`__
  * :bz:`1763971`

* **Completed many production deployments**

  Between Socorro and Tecken, I did 70 production deployments.

  * socorro: 34
  * antenna: 16
  * socorro-submitter: 3
  * tecken: 17

* **Maintained libraries and utilities**

  I also maintain a slew of libraries. In 2022, I switched to a model where I
  don't touch projects except to:

  * fix a security issue
  * support a new version of Python
  * fix an issue affecting me

  I thought that'd reduce the amount of time and energy I was spending
  maintaining all these things. It didn't quite work out, but I think
  the theory is still good.

  With that in mind, I did a whole bunch of releases, but generally I'm
  switching to a once-a-year maintenance pass for most projects.

  Updates to tools and libraries I maintain:

  * markus: Python library for emitting metrics and testing metrics code:
    `v4.0.1 <https://github.com/willkg/markus/releases/tag/v4.0.1>`__ and
    `v4.1.0 <https://github.com/willkg/markus/releases/tag/v4.1.0>`__

  * everett: Python library for configuration, testing configuration, and
    documenting configuration: 
    `v3.0.0 <https://github.com/willkg/everett/releases/tag/v3.0.0>`__ and
    `v3.1.0 <https://github.com/willkg/everett/releases/tag/v3.1.0>`__

  * kent: fake Sentry service for local development:
    `v0.1.0 <https://github.com/willkg/kent/releases/tag/0.1.0>`__,
    `v0.2.0 <https://github.com/willkg/kent/releases/tag/0.2.0>`__,
    `v0.3.0 <https://github.com/willkg/kent/releases/tag/0.3.0>`__,
    `v0.4.0 <https://github.com/willkg/kent/releases/tag/0.4.0>`__,
    `v0.4.1 <https://github.com/willkg/kent/releases/tag/0.4.1>`__, and
    `v0.5.0 <https://github.com/willkg/kent/releases/tag/0.5.0>`__. Then
    I decided it's good and I did a
    `v1.0.0 release <https://github.com/willkg/kent/releases/tag/1.0.0>`__.

  * fillmore: Python library for filtering Sentry events:
    `v0.1.0 <https://github.com/willkg/fillmore/releases/tag/v0.1.0>`__,
    `v0.1.1 <https://github.com/willkg/fillmore/releases/tag/v0.1.1>`__, and
    `v0.1.2 <https://github.com/willkg/fillmore/releases/tag/v0.1.2>`__.
    Then I decided this project is good and I did a
    `v1.0.0 release <https://github.com/willkg/fillmore/releases/tag/v1.0.0>`__.

  * docker-test-mozilla-django-oidc: a set of Docker images for developing and
    testing `mozilla-django-oidc
    <https://github.com/mozilla/mozilla-django-oidc>`__ and acting as a
    testprovider for local development:
    `v0.10.0 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.0>`__,
    `v0.10.1 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.1>`__,
    `v0.10.2 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.2>`__,
    `v0.10.3 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.3>`__,
    `v0.10.4 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.4>`__,
    `v0.10.5 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.5>`__,
    `v0.10.6 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.6>`__, and
    `v0.10.7 <https://github.com/mozilla/docker-test-mozilla-django-oidc/releases/tag/v0.10.7>`__.

  * puente: Python library for Django/Jinja2 extract/merge localization stuff; I
    ended this project in May with a final `v1.0.0
    <https://github.com/mozilla/puente/releases/tag/v1.0.0>`__ release.

  * dennis: Python library and command line utilities for working with gettext PO files; I
    passed this project off after doing a `v1.0.0
    <https://github.com/mozilla/dennis/releases/tag/v1.0.0>`__ release.

  * fx-crash-sig: library for symbolicating and generating crash signatures for
    stacks:
    `v1.0.0 <https://github.com/mozilla/fx-crash-sig/releases/tag/1.0.0>`__

  * socorro-siggen: library for generating crash signatures:
    `v1.0.9 <https://github.com/willkg/socorro-siggen/releases/tag/v1.0.9>`__,
    `v1.0.20220909 <https://github.com/willkg/socorro-siggen/releases/tag/v1.0.20220909>`__, and
    `v1.1.20221108 <https://github.com/willkg/socorro-siggen/releases/tag/v1.1.20221108>`__.

  * bleach: Python library for sanitizing user-supplied text for HTML:
    `v5.0.0 <https://github.com/mozilla/bleach/releases/tag/v5.0.0>`__ and
    `v5.0.1 <https://github.com/mozilla/bleach/releases/tag/v5.0.1>`__.
    I finished up the 6.0.0 earlier today (January 23rd, 2023), but I did the
    bulk of that release at the end of 2022.

  * sphinx-js: Sphinx extension for auto-documenting JavaScript and TypeScript
    code; I shepherded two releases, but didn't do most of the work that went
    into them:
    `v3.2.0 <https://github.com/mozilla/sphinx-js/releases/tag/3.2.0>`__ and
    `v3.2.1 <https://github.com/mozilla/sphinx-js/releases/tag/3.2.1>`__.

  * crashstats-tools: Utilities for working with the `Crash Stats
    <https://crash-stats.mozilla.org>`__ APIs:
    `v1.3.0 <https://github.com/willkg/crashstats-tools/releases/tag/v1.3.0>`__ and
    `v1.4.0 <https://github.com/willkg/crashstats-tools/releases/tag/v1.4.0>`__.

  * rob-bugson: Firefox addon that helps tie GitHub to Mozilla Bugzilla: 
    `v1.6.3 <https://github.com/willkg/rob-bugson/releases/tag/v1.6.3>`__,
    `v1.6.4 <https://github.com/willkg/rob-bugson/releases/tag/v1.6.4>`__, and
    `v1.6.5 <https://github.com/willkg/rob-bugson/releases/tag/v1.6.5>`__.

  * paul-mclendahand: Utility for combining GitHub pull requests which makes
    dependabot less of a drag:
    `v2.1.0 <https://github.com/willkg/paul-mclendahand/releases/tag/v2.1.0>`__

  That's 39 releases of 14 libraries and utilities.

  In December, I did another round of Volunteer Responsibility Amnesty Day.

  * Blog post: :doc:`vrad_2022_12`.

I also did a bunch of small features, signature generation things,
reprocessing, bug fixing, docs fixes, consulting with other groups about crash
reprint, and other things.

Personal things:

* **More PTO**

  I took several weeks off over the course of the year to reduce burnout. I
  think I ended the year with no PTO in the bank. I'm not entirely sure because
  Mozilla switched PTO management tools and I'm confused and can't figure out
  how much PTO I have.

* **Laptop refresh**

  In November, I ordered a laptop refresh and got it at some point, but wasn't
  able to do anything about it until mid-December.

  I tried to build a dev system on Windows 11 but failed miserably. I gave up
  and went back to Linux which I've been using as my workhorse for like 15
  years now.

  With the old laptop, I was having problems with it running out of memory and
  freezing a couple of times a week as well as other stability issues. Plus it
  wasn't powerful enough to drive two external monitors.

  The new laptop is soooo much better. I don't run out of memory. It doesn't
  freeze. I don't lose work. It can drive two external monitors. It's super.

* **Replaced my desk top**

  I have a standing desk frame and built a desk top for it a number of years
  ago. It was too thin and over the years it began to curve. I'd put my pencil
  down and it'd roll off. Very irritating.

  I did a house project and as part of that project, I had to take apart my
  whole office and relocate to another room for a few weeks. I took that
  opportunity to replace the failing desk top I've had for years with a new one
  that is flat. It's so much better and less irritating.


Retrospective for 2022
======================

2022 was too much. I continue to pare down the number of things I'm juggling
with a diverse set of tools:

1. finish projects
2. deprecate projects
3. put projects on ice for a year
4. pass projects off to other people
5. reduce the scope of projects
6. abandon projects

It feels like I always have too much on my plate regardless of what I do.

Still, it was nice to finish up the schema-driven overhaul. That was a huge
project I've been thinking about and talking about in various ways forever.
Also, replacing my desk top and my laptop have reduced daily frustration
significantly.


Thanks
======

Many thanks to Mark who looks out for me and makes it easier for me to be me and
me to do the things I do. I wish everyone had a Mark or a Mark-like. I would
eagerly pay for Mark-as-a-Service! I said the same in 2021.

Many thanks to Jason who's a first-rate SRE! But then he moved on and many
thanks to Christina and Harold!

Many thanks to Aria, Gabriele, Jeff, Markus, Calixte, Roger, and Ted whose
efforts on Rust-ifying everything and knowledge of crash reporting and
engineering minutia are critical to any success I might ever have with
anything! I said the same in 2021.

Many thanks to Lonnen whose historical knowledge helps give context to the
eldritch weirdness!

Many thanks to John, Rob, Paul, Chutten, and everyone else who make up my peer
support group!

Many thanks to you, dear reader, for getting through this omnibus! I hope it was
helpful to you.


Stats
=====

Here's some Bugzilla and GitHub numbers because it's easy to build Bugzilla and
GitHub numbers and sometimes they're interesting.


Bugzilla
--------

::

  Bugs created: 402
  Creators: 55

       Will Kahn-Greene [:willkg] ET  : 277
           Gabriele Svelto [:gsvelto] : 37
            Andrew McCreight [:mccr8] : 10
             Markus Stange [:mstange] : 10
       Alexandre LISSY :gerard-majax  : 7
       Sebastian Hengst [:aryx] (need : 4
           Daniel Holbert [:dholbert] : 3
                             :eduardo : 3
       Steven Michaud [:smichaud] (Re : 2
                           and others ...

  Bugs resolved: 410

                           WORKSFORME : 7
                                FIXED : 356
                              INVALID : 6
                             INACTIVE : 4
                              WONTFIX : 18
                            DUPLICATE : 13
                                MOVED : 1
                           INCOMPLETE : 4

  Resolvers: 15

       Will Kahn-Greene [:willkg] ET  : 357
           Gabriele Svelto [:gsvelto] : 32
                             :eduardo : 7
                         continuation : 2
        Alexandre LISSY :gerard-majax : 2
                           and others ...

  Commenters: 106

                               willkg : 1941
                              gsvelto : 138
                          mstange.moz : 39
                    lissyx+mozillians : 27
                         continuation : 21
                               efilho : 21
                           and others ...

  Statistics

      Youngest bug : 0.0d: 1748856: socorro deploy: 2022.01.06
   Average bug age : 213.1d
    Median bug age : 9.0d
        Oldest bug : 3119.0d: 1008289: No test coverage on report/index with `parsed_d...


GitHub
------

::

  mozilla-services/socorro
    Merged PRs: 254

    Committers:
               willkg :   227  (+24327, -17639,  505 files)
       gabrielesvelto :    17  (  +122,   -224,    3 files)
             jrmuizel :     5  (   +11,     -0,    2 files)
        Archaeopteryx :     1  (    +1,     -0,    1 files)
             cpeterso :     1  (    +8,    -20,    2 files)
            jwhitlock :     1  (    +1,     -1,    1 files)
            edugfilho :     1  (    +5,     -5,    1 files)
            tirkarthi :     1  (    +6,     -5,    3 files)

                Total :        (+24481, -17894,  508 files)

    Most changed files:
      socorro/processor/rules/mozilla.py (44)
      socorro/external/es/super_search_fields.py (34)
      socorro/unittest/processor/rules/test_mozilla.py (33)
      requirements.in (28)
      requirements.txt (28)
      socorro/schemas/processed_crash.schema.yaml (24)
      socorro/processor/processor_pipeline.py (23)
      docker/Dockerfile (23)
      webapp-django/crashstats/crashstats/models.py (22)
      socorro/signature/siglists/irrelevant_signature_re.txt (20)

    Age stats:
          Youngest PR : 0.0d: 6285: bug 1796094: fix JSLargeAllocationFailure OOM d...
       Average PR age : 0.3d
        Median PR age : 0.0d
            Oldest PR : 50.0d: 6219: Bug 1795631 - Ignore the RefPtr class and its h...

  mozilla-services/antenna
    Merged PRs: 67

    Committers:
               willkg :    67  ( +3570,  -3060,   61 files)

                Total :        ( +3570,  -3060,   61 files)

    Most changed files:
      requirements.txt (23)
      requirements.in (22)
      antenna/breakpad_resource.py (14)
      tests/unittest/test_breakpad_resource.py (10)
      docker/Dockerfile.fakesentry (9)
      .circleci/config.yml (9)
      docker/Dockerfile (8)
      tests/unittest/test_sentry.py (6)
      Makefile (6)
      docker-compose.yml (5)

    Age stats:
          Youngest PR : 0.0d: 897: Updates 20221202
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 897: Updates 20221202

  mozilla-services/tecken
    Merged PRs: 97

    Committers:
               willkg :    91  ( +6439,  -8565,  213 files)
            edugfilho :     5  (  +648,   -369,   10 files)
              mstange :     1  (  +165,    -32,    5 files)

                Total :        ( +7252,  -8966,  214 files)

    Most changed files:
      requirements.in (33)
      requirements.txt (33)
      tecken/settings.py (13)
      eliot-service/tests/test_sentry.py (12)
      Makefile (11)
      eliot-service/tests/test_cache_manager.py (10)
      docker-compose.yml (10)
      tecken/tests/test_sentry.py (9)
      tecken/tests/test_api.py (9)
      tecken/api/views.py (8)

    Age stats:
          Youngest PR : 0.0d: 2656: Updates 20221202
       Average PR age : 1.3d
        Median PR age : 0.0d
            Oldest PR : 60.0d: 2579: bug 1779633: update symbolic and emit inlines 

  mozilla-services/socorro-submitter
    Merged PRs: 11

    Committers:
               willkg :    11  ( +1582,  -1306,   27 files)

                Total :        ( +1582,  -1306,   27 files)

    Most changed files:
      requirements-runtime.txt (4)
      requirements.in (4)
      requirements.txt (4)
      tests/test_submitter.py (4)
      requirements-dev.in (3)
      requirements-dev.txt (3)
      src/submitter.py (3)
      Makefile (2)
      bin/list_runtime_reqs.sh (2)
      bin/rebuild_reqs.sh (2)

    Age stats:
          Youngest PR : 0.0d: 48: Update dependencies
       Average PR age : 0.2d
        Median PR age : 0.0d
            Oldest PR : 2.0d: 37: bug 1756223: switch to cimg/base for CI

  mozilla-services/minidump-stackwalk

  mozilla/fx-crash-sig
    Closed issues: 17

    Merged PRs: 15

    Committers:
               willkg :    15  ( +2394,   -801,   22 files)

                Total :        ( +2394,   -801,   22 files)

    Most changed files:
      setup.py (6)
      .github/workflows/main.yml (5)
      README.md (5)
      requirements-dev.txt (4)
      tox.ini (4)
      fx_crash_sig/cmd_get_crash_sig.py (3)
      fx_crash_sig/crash_processor.py (3)
      fx_crash_sig/example.py (3)
      Makefile (2)
      bin/release.sh (2)

    Age stats:
          Youngest PR : 0.0d: 66: Fix pull_request event types
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 66: Fix pull_request event types

  willkg/socorro-siggen
    Closed issues: 9

    Merged PRs: 16

    Committers:
               willkg :    16  ( +1138,   -776,   26 files)

                Total :        ( +1138,   -776,   26 files)

    Most changed files:
      siggen/generator.py (5)
      siggen/rules.py (5)
      siggen/socorro_sha.txt (5)
      siggen/tests/test_rules.py (5)
      HISTORY.rst (4)
      siggen/__init__.py (4)
      README.rst (4)
      siggen/cmd_signature.py (4)
      setup.py (4)
      siggen/siglists/irrelevant_signature_re.txt (4)

    Age stats:
          Youngest PR : 0.0d: 104: Update actions and fix workflow events
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 104: Update actions and fix workflow events

  willkg/crashstats-tools
    Closed issues: 16

    Merged PRs: 26

    Committers:
               willkg :    26  ( +3260,   -614,   18 files)

                Total :        ( +3260,   -614,   18 files)

    Most changed files:
      src/crashstats_tools/cmd_supersearch.py (10)
      src/crashstats_tools/cmd_supersearchfacet.py (9)
      src/crashstats_tools/cmd_fetch_data.py (6)
      src/crashstats_tools/utils.py (6)
      src/crashstats_tools/cmd_reprocess.py (5)
      setup.py (5)
      Makefile (4)
      tests/test_fetch_data.py (4)
      tox.ini (4)
      requirements-dev.txt (3)

    Age stats:
          Youngest PR : 0.0d: 83: Add command line help to README (#79)
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 83: Add command line help to README (#79)


  All repositories:

    Total closed issues: 42
    Total merged PRs: 486
