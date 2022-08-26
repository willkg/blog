.. title: Socorro Engineering: 2021 retrospective
.. slug: socorro_2021
.. date: 2021-12-22 12:00:00 UTC-05:00
.. tags: mozilla, work, socorro, tecken, dev

Summary
=======

2020h1 was rough and :doc:`2020h2 was not to be outdone <socorro_2020_h2>`. 2021h1
was worse in a lot of ways, but I got really lucky and a bunch of things
happened that made 2021h2 much better. I'll talk a bit more about that towards
the end.

But this post isn't about stymying the corrosion of multi-year burnout--it's a
dizzying retrospective of Socorro engineering in 2021.


.. TEASER_END


Highlights of 2021
==================

This is long. 

* **Fixed bugs in Breakpad minidump-stackwalk (C++, bash)**

  I fixed a handful of issues in `minidump-stackwalk
  <https://github.com/mozilla-services/minidump-stackwalk/>`_.  I fixed printing
  addresses to be left-padded so they sort better, improved project scaffolding
  and scripts, and documented the JSON output.

  I also reviewed several pull requests from gsvelto and gankra for adding
  support for printing ``winerror.h`` error codes, printing ``__fastfail`` error
  codes, thread names, interpreting ``mac_crash_info``, printing ``NTSTATUS``
  error codes, listing unloaded modules, surfacing the ``LastErrorValue``,
  better support for AArch64 when encountering buggy CFI information, and
  support for AMD64 and X86 variable-sized contexts.

* **Ended email address collection**

  Since the beginning of crash collection at Mozilla, we've asked users to
  add their email address to crash reports. Early on, this was really helpful
  as it allowed us to contact users and get more information about what was
  going on when Firefox crashed.

  Some crash reporter dialogues had an email field in the form, but many did
  not. Further, crash reporter dialogues in other products did not have an
  email field. I wanted to either fix all the forms so they all had an email
  field or end collection for it.

  In 2020, I worked on figuring out whether it was still useful. I talked to
  people across the company: product managers, engineers, people involved in
  stability efforts. However, I wasn't able to build a compelling case to keep
  it.

  Email addresses are identifiable information. Without a compelling case to
  collect and store email addresses, `we should stop collecting and storing it
  <https://www.mozilla.org/en-US/about/policy/lean-data/>`_.

  In 2021, I added the email field to the list of fields we remove from crash
  reports before ingestion. I removed all email-field-related bits from the
  processor and Crash Stats websites. I also removed the email field code from
  Firefox crash reporter dialogues. This was incredibly difficult since that code
  is ancient, has no tests, and is pretty fickle. For example, the macOS dialog
  is implemented in an old ``.nib`` format which xcode doesn't support so
  there's no way to edit it until we rewrite the crash reporter dialog.

  This work was done in :bz:`1688883`.

* **Removed derogatory language from repositories**

  I switched the main branch to "main" in all Socorro-related repositories and
  removed/replaced derogatory language.

* **Added support for Breadcrumbs and structured JavaException annotations**

  The `android-components
  <https://github.com/mozilla-mobile/android-components/tree/main/components/lib/crash>`_
  library supports sending crash reports to both Sentry as well as Socorro and
  this is the library that Mozilla's Android products use. The code for sending
  crash reports to Sentry sends breadcrumbs data with crash reports. Breadcrumbs
  can add context to crash reports which can help in debugging.
  
  I worked with Roger to define a structured form for breadcrumbs information,
  include it as the ``Breadcrumbs`` crash annotation, and surface it in the
  report view for crash reports on Crash Stats.

  Fennec and Fenix both sent crash reports for Java crashes. Instead of
  including a minidump which Socorro can process to get a symbolicated stack of
  the crash, crash reports from Java processes send a ``JavaStackTrace``
  annotation which has an unstructured string representing the stack of the
  crash. Because it's unstructured, it's difficult to do anything with. We can't
  display it with additional information. We can't use it for improving
  signature generation for Java crashes.

  I worked with Roger to define a structured form for Java crashes and we put
  this in the new ``JavaException`` annotation. It's displayed in the report
  view. In the future, we will use this for overhauling signature generation for
  Java crashes.

  I want to continue to improve crash ingestion for Java crashes and Android
  products.

  .. Note::

     Do you work on Android products? What can I do to improve crash ingestion
     and Crash Stats for you?


* **Overhauled Elasticsearch crash storage**

  Socorro's processor indexed arbitrary crash data not specified in a schema in
  Elasticsearch in a way that was unusable, took up storage space, and made it
  difficult to know exactly what data we were storing. Further, this created
  type errors when adding new things to the index that were difficult to work
  around.

  I reworked the Elasticsearch crash storage code to only index crash data
  specified in a schema. This reduced storage use, made it easier to know what
  was and wasn't in the index, and completely eliminated type errors when adding
  new fields.

  This also gets us closer to being able to either upgrade Elasticsearch to a
  more recent version or migrate off of it.

* **Improved symbolication and signature generation**
  
  The ultimate goal is to support symbolication and signature generation for
  data sets outside of crash reports in Socorro. This includes address
  information in the Firefox profiler, symbolicating and generating signatures
  for crash ping data, symbolicating and generating signatures for crashes in
  Firefox CI, etc.

  I've been working on this for several years now. The systems and libraries
  involved are all in active use and the project is huge, so progress is in
  small, incremental steps. I made a lot of progress in 2021 even if it doesn't
  look like it.

  I hacked some fixes in `fx-crash-sig
  <https://github.com/mozilla/fx-crash-sig>`_ to unblock the graphics and
  Fission teams trying to use the crash ping data. I started on a rewrite to
  improve the API making it easier to use especially for symbolicating and
  generating signatures for large batches. I might be able to get to that soon.
  I pushed out 3 releases this year.

  I fixed a variety of issues in `socorro-siggen
  <https://github.com/willkg/socorro-siggen>`_. It still requires manual syncing
  with the signature generation code in Socorro. I pushed out 4 releases.

  I completed and pushed to production the `new Mozilla Symbolication Service
  <https://symbolication.services.mozilla.com>`_. The new service is built on
  top of `Symbolic <https://github.com/getsentry/symbolic>`_ which Mozilla is
  increasingly using in our crash reporting ecosystem. This supports line
  numbers and other file data and set us up for possible future support of
  inline functions and other debug info files. It also allows us to optimize
  performance specifically for symbolication without having to worry about the
  other responsibilities of the Mozilla Symbols Server. It's also a big step in
  the effort of Rust-ifying crash reporting. I plan to write up a project
  retrospective for this in 2022.

  I also finished an alpha-quality API for signature generation. I want to
  improve the API to make it easier to use for data sets that aren't crash
  reports and crash pings. That will likely lead to backwards incompatible
  changes to the API. I'm planning to finish this up in 2022. You can see what
  we've got at `<https://crash-stats.mozilla.org/api/#CrashSignature>`_.

* **Established Crash Reporting Working Group**
  
  Unlike Telemetry where the bulk of the people working on the client,
  ingestion, tooling, and analysis for Telemetry data are all in Data Org, the
  wild wild world of crash reporting is all over Mozilla. It feels chaotic to me
  and I keep getting surprised by initiatives that need crash ingestion support.
  Further, we've got a lot of historical knowledge, the documentation is all
  over the place and isn't great, it's hard to find support for crash reporting
  related problems, and it's probably the case that if we collectively focused
  on specific initiatives, we could achieve so much more.

  With that, I figured I'd create a `Crash Reporting Working Group
  <https://wiki.mozilla.org/Data/WorkingGroups/CrashReporting>`_ and see if we
  could use that to pull everything and everyone together.

  I was all over the place this years, so I didn't spend as much time on this as
  I wanted to. With a lot of help from Gabriele, I think we improved the
  situation in a few key ways:

  * we renamed #breakpad to #crashreporting on Matrix and pushed that as the
    singular place for support for crash reporting, Crash Stats, symbols, etc
  * we did an inventory of projects, teams, and owners for `crash reporting
    related things
    <https://wiki.mozilla.org/Data/WorkingGroups/CrashReporting#Crash_reporting_projects.2Fteams>`_
    making it easier to find people
  * I started monthly newsletters detailing changes in crash reporting ecosystem
  * Gabriele ran a Crash Reporting All Hands giving stakeholders a
    chance to see what's going on and bring up their issues which we could
    factor into ongoing development efforts
  
  In 2022, Gabriele wants to focus on updating, consolidating, and improving the
  documentation around crash reporting. Towards this, I want to work on the
  crash ingestion side of that and it'd be great to finally build out data
  documentation for crash annotations similar to what Telemetry has with the
  `Glean Dictionary <https://dictionary.telemetry.mozilla.org/>`_.

* **Unified conventions and standards across the Socorro-verse**
  
  The crash ingestion pipeline and symbols services are composed of a myriad of
  repositories, libraries, infrastructure code, tooling, and other things. It's
  hard on me when things are different across them all. Some of them I built,
  but many of these pieces I inherited from other individuals and teams over
  the years.

  In 2021, I worked on unifying the pieces that affect development and
  maintenance workflow. Things like Dockerflow setups, scripts, makefiles,
  testing harnesses, documentation tooling, release tooling, bug systems,
  metrics, and system test tooling.

  I'm reworking all of the service components to use `Everett
  <https://everett.readthedocs.io>`__ for configuration. This makes it a lot
  easier to write configuration-using code, tests, and documentation.

  In doing that, I reduced a lot of friction I have when switching between
  pieces of the project. That's helped. There's still some other things I want
  to do, but I'll get there when I get there.

  I'm keeping an eye on the various initiatives to standardize technology and
  architecture for services at Mozilla. As those initiatives move towards more
  concrete conventions, standards, and guidelines, I'll update Socorro-verse
  things accordingly.

* **Fixed a bug in dump_syms (Rust)**

  I fixed a bug in dump_syms to normalize "anonymous namespace" symbols which
  fixed an issue with signature generation in Socorro. It wasn't a big bug, but
  it was pretty straight-forward to fix. I like working in Rust.

  This was done in `pr 192 <https://github.com/mozilla/dump_syms/pull/192>`_.

* **Updated socorro-submitter to improve parity with collector**

  Over the last couple of years, we've made changes to how the crash reporting
  client submits crash reports to the Socorro collector. Socorro has a
  `socorro-submitter <https://github.com/mozilla-services/socorro-submitter>`_
  that resubmits crash report data from the prod to stage environment.

  I finally got around to fixing the collector and socorro-submitter to submit
  crash reports from prod to stage in the same way they were submitted to prod.
  That helps us suss out issues in the crash ingestion pipeline in our stage
  environment.

* **Crash data improvements**

  I rewrote the macOS version normalization code to correctly follow the Mac
  platform OS names across the different versions.

  I rewrote the Windows version normalization code in the same way handling
  Windows 11 builds.

  I added a ``major_version`` field which is indexed making it easier to search
  for all crash reports for a specific major version. This was a feature
  request that came up pretty often. :bz:`1111612`

  We added support for ``mac_crash_info`` extracted from the minidump, though
  it's not particularly great.

  We added support for ``WindowsErrorReporting`` annotation.

  I added a ``crash_report_keys`` field which is a list of all the crash
  annotation names and names of dumps that came in the crash report. This allows
  us to search for crash reports that included a specific file or annotation.
  This makes adding support for new annotations a lot easier because it'll be
  easier to find example crash reports. Gabriele says this also allows us to
  deprecate unused annotations, too--something that's been very difficult to do
  until now.

* **Improved report view in Crash Stats**

  Personally, I hate the report view in Crash Stats. I find it disorganized,
  confusing, and ugly. I have extremely strong feelings about this for whatever
  reasons. I blame myself.  

  Anyhow, in 2021, I made some minor improvements:

  * Redid what is now the *Crash Annotations* tab so it includes the original
    values of the crash annotations that came in the crash report. It's also
    clearer which fields are public and which are protected data. I also tried
    to break out the metadata that the crash ingestion pipeline adds to the
    crash report so that's clearer, but that's still a work in progress.
  * Redid what is now the *Raw Data and Minidumps* tab so it has more convenient
    links to artifacts we're storing (raw crash, processed crash, dumps, memory
    report, etc) and is clearer about what's protected data. I still don't like
    this tab, but it's "better".
  * Improved the *Extensions* tab in Crash Stats so it shows the signed state.
  * Fixed the *Correlations* tab so it always shows up with either correlations
    data or a helpful message even if correlations aren't available. 
  
  I also implemented a *Debug* tab which I wish I had thought of years ago. The
  *Debug* tab is the magical place where we can collect all the information
  about how a crash report was ingested so as to debug ingestion and
  stackwalking issues. It's amazing and has already been incredibly useful. In
  2022, I'll add signature generation notes.

* **Wound down the tools-socorro mailing list**

  Before I started working on Socorro, it was an open source project and had
  multiple companies running their own Socorro installation. As I understand it,
  this was coordinated using the tools-socorro mailing list.

  When I joined Socorro, that list was pretty dead and we had no contact with
  anyone running their own Socorro.

  I refocused the Socorro project so it was the code that ran the Mozilla crash
  ingestion pipeline and ended supporting other people running their own crash
  ingestion pipelines. I've talked about this before.

  Anyhow, the last step here was to wind down the tools-socorro mailing list.

* **crashstats-tools improvements**

  I improved argument handling for `crashstats-tools
  <https://github.com/willkg/crashstats-tools>`_ and redid ``supersearchfacet``
  so it supported other periods.

  So now you can do something like this::

    $ supersearchfacet --_facets=product --period=daily
    date                 Fenix  Firefox  FirefoxReality  Focus  ReferenceBrowser
    2021-12-14 00:00:00  55723  101260   125             1598   0
    2021-12-15 00:00:00  50878  111818   202             1492   1
    2021-12-16 00:00:00  51651  101585   129             1308   0
    2021-12-17 00:00:00  51688  99147    121             1353   0
    2021-12-18 00:00:00  54984  59396    97              1490   0
    2021-12-19 00:00:00  54076  55369    202             1582   0
    2021-12-20 00:00:00  52187  81295    127             1560   0
    2021-12-21 00:00:00  50243  74869    99              1381   0

  crashstats-tools are written in Python, but I'd like to rewrite them in Rust.
  Users of crashstats-tools are predominantly running Rust command line tools
  and it'd be a lot easier for them to install and use if written in Rust.

* **Consulted on crash reporting**

  Gabriele is the go-to person for helping with crash reporting client work and
  I'm the go-to person for the crash ingestion and analysis side.

  I consulted on:

  * Analysis on Fission crashes

    This was tricky because Fission crashes aren't like main and content process
    crashes, so we can't pop up a crash reporting dialog. All the options kind
    of sucked. I think they eventually went with looking at Crash Stats for what
    it had and ad hoc analysis of crash ping data for the bigger picture view.

    I wish we could have done better here, but I don't have the required bits
    set up, yet.

  * Analysis of top crashers

    Crash report data isn't representative of crashes our users are
    experiencing. The graphics team was working hard on webrender and needed a
    better data set representative of what our users were experiencing. I fixed
    issues with fx-crash-sig and socorro-siggen allowing them to put together an
    extremely impressive `top crashers
    <https://www.mathies.com/mozilla/crashes/>`_ dashboard.

  * ProClient crashes

  * MozillaVPN crashes

    MozillaVPN is implementing crash reporting. I worked with Marcus to set up
    Crash Stats and debug issues with crash submission. (As of this writing, I
    think he's got it working). While we were debugging, I improved the
    documentation for crash reporting clients to be more helpful for projects
    that aren't using Breakpad tooling.

  Consulting helped improve documentation and support for other crash reporting
  clients.

  .. Note::
    
     If you're a product manager and starting a new product, please get in touch
     with me early on to make your crash reporting story a lot easier for all of
     us!

* **Documentation improvements**

  I redid the architecture and flow diagrams for Socorro and Tecken. This is the
  first major update to the diagrams we've done in several years. This was an
  important thing to do before figuring out the AWS to GCP migration.

  Previously, I was using graphviz dot notation because it's a text-based source
  that I can manage and maintain with text-based tools like git, grep, and text
  editors. However, it's really finicky to render and I spent a lot of time
  tweaking the diagrams so they rendered in a readable way.

  Jeff said we're switching to mermaid.js and diagrams.net. I had the same
  problems with mermaid.js that I did with graphviz/dot. I tried out
  diagrams.net and if I save the diagram as a SVG and export as PNG then I can
  do all the things I want to do and I get a much better diagram out of it.

  * `Socorro diagram <https://socorro.readthedocs.io/en/latest/overview.html>`_

  * `Tecken diagram <https://tecken.readthedocs.io/en/latest/overview.html>`_

  I documented the `JSON schema for minidump-stackwalk output
  <https://github.com/mozilla-services/minidump-stackwalk#minidump-stackwalk-output>`_.
  This turned out to be really helpful when switching to the new Rust minidump
  stackwalker. This also helped us remove some code in the Socorro processor
  for fields that were redundant or no longer used.

  I rewrote the Overview documents for Socorro and Tecken after reading
  `ARCHITECTURE.md
  <https://matklad.github.io//2021/02/06/ARCHITECTURE.md.html>`_ blog post.

  I switched to capturing architecture decisions with ADRs and then backfilled
  `ADRs for Socorro
  <https://github.com/mozilla-services/socorro/tree/main/docs/adr>`_ and `ADRs
  for Tecken <https://github.com/mozilla-services/tecken/tree/main/docs/adr>`_.
  This is in line with what other parts of Mozilla are now doing. Plus it'll
  help me remember what past me was thinking. I have some more ADRs to backfill.
  I'll continue working on this in 2022.

  I improved the `Specification: Submitting crash reports
  <https://socorro.readthedocs.io/en/latest/spec_crashreport.html>`_ document to
  focus it on people writing crash reporting clients that aren't based on the
  Breakpad upload tool or our existing crash reporting client machinery.

  I did a :doc:`Socorro Overview: 2021 presentation <socorro_overview_2021>`. In
  order to do that, I had to write a thing to export my slides into a blog post
  form.
  
  I updated infrastructure documentation and runbooks for all the services I
  maintain.

  I overhauled the documentation in Mana for Socorro and Tecken and pulled it
  into the Data Org space.

  Crash ingestion involves handling of category 4 data (see `Data Collection
  <https://wiki.mozilla.org/Data_Collection>`_). One of my jobs is thinking
  about what we're collecting, how it's accessed, and what happens to it.
  
  With help from Nneka and Emily, I honed our data collection, access, and
  retention policies. I started a Data Sharing Decision log as well. This will
  help us be more consistent even as staff come and go.

  It's great that this exists, but one of the problems the Socorro-verse has is
  that information is in a bunch of different places and that's confusing and
  makes things difficult to find for anyone who isn't me.

  In 2022, I'll be working on straightening out the crash ingestion
  documentation story. I'm keeping tabs on other standards and conventions at
  Mozilla that I can adopt to make things more consistent.

* **Ended collection of FennecAndroid, Thunderbird, and SeaMonkey crash reports**

  FennecAndroid is the version of Firefox for Android before the Fenix rewrite.
  We have migrated users to the new version and we no longer support the old
  version. I contacted product managers to establish that this data no longer
  helps us and then ended collection.

  I've been working on ending collection for Thunderbird and SeaMonkey for
  several years. This was tougher because these two projects are still in use
  and I needed to help both projects migrate to other services. That took a
  while.

* **Switched to new Rust-based minidump-stackwalker**

  Turns out this was the year!

  Aria, with help from Gabriele, Ted, and others, worked on `rust-minidump
  <https://github.com/luser/rust-minidump>`_ and achieved parity with the
  Breakpad minidump-stackwalker the Socorro processor was using.

  I implemented build tooling, a processor rule to run the new stackwalker, a
  feature flag to let us switch between the two stackwalkers, several test
  harnesses to validate the new stackwalker, and redid some parts of the
  processor to make it easier to observe and debug the new stackwalker in a
  server environment. This was the impetus behind the new *Debug* tab.
  
  I wrote up a migration plan. I `examined differences in output
  <https://bugzilla.mozilla.org/show_bug.cgi?id=1744323>`_ and `performance
  <https://bugzilla.mozilla.org/show_bug.cgi?id=1744320>`_ between the two
  stackwalkers. I reviewed and tested rust-minidump pull requests.

  After a flurry of work, we did the final migration switching the production
  environment to the new stackwalker last week. CPU and memory usage metrics on
  the processors went down. Several errors we were getting vanished. It was a
  perfect deploy.

  Check out the average timing for the stackwalker rule drop by half:

  .. thumbnail:: /images/socorro_2021_processor_new_stackwalker.png

     Average timings when transitioning from
     BreakpadStackwalkerRule2015 to MinidumpStackwalkerRule

  The stackwalker rules take up the vast majority of the time it takes to
  process a crash report so switching to the new Rust-based stackwalker
  effectively halves the amount of time it takes to process crash reports.

  I plan to write up a project retrospective on this in 2022.

I also did a bunch of small features, signature generation changes,
reprocessing, bug fixes, docs fixes, and other things.

Other non-Socorro-verse things:

* **Reviewed Bleach pull requests and re-upped as co-maintainer**

  I stepped down from Bleach in :doc:`March 2019 <bleach_stepping_down>`, but I
  continued to help out with reviewing changes. Bleach development has slowed
  way down, but we had one security issue and a handful of other things to work
  through.

  In December 2021, I stepped back up as co-maintainer. I started working
  through issues and pull requests. I think I want to keep Bleach maintenance to
  a minimum and only work on things that are urgent and/or necessary.

* **Switched to Jupyter for analysis**

  I switched to using Jupyter for data analysis. For a long time, I've been
  looking for a way to capture data and analysis such that it stuck around and
  was viewable long after the fact. Socorro crash report data expires after 6
  months, Grafana data expires after 6 months, logs expire, etc.

  GitHub can show notebooks, so I discovered if I save the notebook and data
  files, I can do my analysis in Jupyter notebooks and save it in a way that
  doesn't expire and allows other people to tinker with the data.

  `<https://github.com/willkg/socorro-jupyter>`_

* **Updates to tooling**

  I made some minor fixes and releases for `rob-bugson
  <https://addons.mozilla.org/en-US/firefox/addon/rob-bugson/>`_.

  I overhauled `paul-mclendahand <https://github.com/willkg/paul-mclendahand>`_
  to require fewer weird configuration settings and setup and support GitHub
  access tokens.

  I improved my `socorro-release <https://github.com/willkg/socorro-release/>`_
  script which I use for creating deploy bugs and tagging releases for services
  I maintain.

  I overhauled `Everett <https://everett.readthedocs.io/>`__ configuration
  components and got about half-way through redoing the Sphinx extension for
  auto-generating configuration documentation. (The new Sphinx extension changes
  are *amazing*. I really wish I had time to finish it up.)

  I did some minor updates to `Markus <https://markus.readthedocs.io/>`_.
  Generally, Markus is "done", so I'm only putting out updates to improve
  documentation and support new Python versions.

* **Joined Data Stewards**

  I joined `Data Stewards <https://wiki.mozilla.org/Data_Collection>`_ and did a
  handful of data reviews.
  
  One of my reasons for joining was to unify Socorro's crash annotation
  processes with Telemetry's data processes. I haven't really gotten very far
  with that, yet. Maybe next year.

* **Started the Data Neighborhood**

  I had a regular 1:1 with `Will <https://wrla.ch/index.html>`_ and during one
  of these conversations, we were talking about how I went on PTO for 5 weeks
  and he took a 5 week sabbatical at the `Recurse center
  <https://www.recurse.com/>`_ and when we came back, it was so quiet. We
  thought about what we could do or facilitate to increase the activity,
  interconnectedness between people, and general feeling of belonging. It's hard
  to describe the project well in a short paragraph, so I'll leave that for
  another blog post.
  
  Anyhow, we started the Data Neighborhood as a way to provide a framework for
  organizing and running activities, events, groups, etc.

  Out of that, we started a ``#data-checkins`` Slack channel where people could
  talk about their day. We started a ``#data-writing-help`` channel for talking
  about writing which is a critical part of our work and also getting help with
  editing and review. We put together a Mana page that listed many groups across
  Mozilla and where they congregate (they're hard to find--there's no index
  anywhere).

  I was talking with Mark about this and my current thinking is that it was a
  good experiment, but it didn't ultimately help much because the hypothesis of
  "if we provide a framework for people to do things, they'll do them!" didn't
  pan out.

  Also, now that Will is leaving, I'm not sure what I'm going to do with this.
  Should I pull in some other people and see where that goes? Should I shelve
  it? What's the next hypothesis we can test out?

Personal things:

* **10-year Moziversary**
  
  In September, I hit my :doc:`10-year Moziversary <mozilla_10_years>`.
  
* **5 weeks of PTO**
  
  I work on Socorro-verse and a bunch of other stuff on my own. It's against my
  nature to step away for periods of time in situations when I'm on my own.
  Who's going to press the button every 108 minutes? What if the island blows up
  while I'm not there?

  But I was incredibly burned out and had been for years and years for all the
  reasons.

  I talked it out with Mark, my manager, who helped me pull off a 5-week PTO.
  During that time, I did nothing. I made no plans. I didn't work on projects. I
  didn't take any trips. I didn't take classes. I didn't read books. I did
  nothing.

  Coming back was so totally weird. I felt like a different person. I look over
  this description and it barely evokes how stark the before and after was.

  I'm still feeling weary and burned out, but I feel much better.

  I've never taken that much PTO off at once in my life. Previously, I would
  quit, take the time off as needed (one time I took a year off), and then join
  a different company. I feel really lucky to have been able to take 5 weeks off
  and come back to an environment where my colleagues were actively looking out
  for my well-being.

* **"Attended" some conferences**
  
  I attended `PyCon 2021 <https://us.pycon.org/2021/>`_, but I also had my
  second vaccine shot, so I slept through the last day.

  I attended the `StaffPlus Live conference
  <https://leaddev.com/course/leaddev-live>`_ which was fascinating. As a new
  Senior Staff Engineer, I found this conference really helped me frame my work
  and role in the things going on around me for my new role plus it helped frame
  the last few years I spent as a Staff Engineer. I had no idea about all the
  stuff I had no idea about. Also, Will Larson's `Staff Engineer: Leadership
  beyond the management track
  <https://www.amazon.com/Staff-Engineer-Leadership-beyond-management/dp/1736417916/>`_
  really helped me up my game.

  I attended `Google Next 21
  <https://cloud.google.com/blog/topics/google-cloud-next/whats-new-at-next>`_.
  I know they put a lot of work and effort into it, but it's such a dizzying
  alphabet soup of service stuff it's hard to follow.

Stuff I worked on, but either abandoned or put on the back burner:

* Folding in socorro-siggen into socorro again
* Overhauling crash signature generation for Java crashes
* Symbolication and signature generation for crash ping data
* fx-crash-sig overhaul for better batch support
* Project planning for a possible Socorro-as-a-service
* Plan for unifying Socorro with Telemetry ingestion pipeline
* Overhauling crash report data structure and building schemas for crash reports
  and processed data
* Supporting debug files other than Breakpad sym
* Supporting inline functions in symbolication


Retrospective for 2021
======================

This post is ridiculously long. When I started writing it, I was of the mind
this year just kind of flew by without much progress and was another let-down of
a year. Now that I've written most of the blog post, I think that's probably not
the case.

I wish I had gotten further on some projects--especially sorting out crash pings
and making that data set more usable. I also wish I hadn't started so many
different things. One of the things I tend to do is move a lot of projects
forward in short, incremental steps towards various goals while keeping
everything working. There's a lot of overall progress, but not a lot of
individual progress and some projects don't hit the jackpot until the very end
when they're finished.

But whatever--I got lots of feelings. I think I done good in 2021.


Thanks
======

Many thanks to Mark who looks out for me and makes it easier for me to be me and
me to do the things I do. I wish everyone had a Mark or a Mark-like. I would
eagerly pay for Mark-as-a-Service!

Many thanks to Jason who's a first-rate SRE!

Many thanks to Aria, Gabriele, Jeff, Markus, Calixte, Roger, and Ted whose
efforts on Rust-ifying everything and knowledge of crash reporting and
engineering minutia are critical to any success I might ever have with anything!

Many thanks to Chris, Jim, Nika, and others who rely on Crash Stats and crash
ingestion for their patience as I muddle along and their insight as to how they
need things to work to do the things they need to do!

Many thanks to Lonnen whose historical knowledge helps give context to the
eldritch weirdness!

Many thanks to Will, Jeff, John, Rob, Paul, Chutten, Les and everyone else who
make up my peer support group!

Many thanks to you, dear reader, for getting through this omnibus! I hope it was
helpful to you.


Stats
=====

Here's some Bugzilla and GitHub numbers because it's easy to build Bugzilla and
GitHub numbers and sometimes they're interesting.

Bugzilla
--------

::

  Bugs created: 311
  Creators: 38

       Will Kahn-Greene [:willkg] ET  : 219
           Gabriele Svelto [:gsvelto] : 30
       Sebastian Hengst [:aryx] (need : 7
       Steven Michaud [:smichaud] (Re : 6
            Andrew McCreight [:mccr8] : 5
             Markus Stange [:mstange] : 4
           Aria Beingessner [:Gankra] : 3
       [PTO until Jan 10th] Agi Sferr : 2
           Jeff Muizelaar [:jrmuizel] : 2
                           and others ...

  Bugs resolved: 316

                              WONTFIX : 22
                                FIXED : 268
                                MOVED : 2
                           WORKSFORME : 9
                            DUPLICATE : 5
                           INCOMPLETE : 5
                              INVALID : 4

  Resolvers: 14

       Will Kahn-Greene [:willkg] ET  : 295
           Gabriele Svelto [:gsvelto] : 10
       Calixte Denizet (:calixte) (in : 2
                         continuation : 1
                        mcastelluccio : 1
                           and others ...

  Commenters: 107

                               willkg : 1472
                              gsvelto : 93
                             smichaud : 44
                              peterbe : 35
                         continuation : 21
                           and others ...

  Statistics

      Youngest bug : 0.0d: 1685461: Upload symbols for the 84.0.1 and 84.0.2 builds...
   Average bug age : 265.1d
    Median bug age : 8.0d
        Oldest bug : 2626.0d: 973894: Supersearch: field exists should be available f...


GitHub
------

::

  mozilla-services/socorro:

    Merged PRs: 221

    Committers:
               willkg :   210  (+13324,  -9110,  285 files)
      dependabot[bot] :     4  (   +52,    -48,    5 files)
             jrmuizel :     2  (    +2,     -0,    2 files)
             jcristau :     2  (    +2,     -1,    2 files)
       gabrielesvelto :     1  (   +26,     -1,    2 files)
             kbrosnan :     1  (    +5,     -2,    1 files)
           amccreight :     1  (    +2,     -0,    1 files)

                Total :        (+13413,  -9162,  285 files)

    Most changed files:
      docker/Dockerfile (36)
      requirements.txt (32)
      requirements.in (30)
      socorro/processor/rules/mozilla.py (28)
      socorro/external/es/super_search_fields.py (28)
      webapp-django/crashstats/crashstats/jinja2/crashstats/report_index.html (22)
      socorro/unittest/processor/rules/test_mozilla.py (21)
      webapp-django/crashstats/crashstats/models.py (20)
      socorro/processor/rules/breakpad.py (18)
      webapp-django/crashstats/crashstats/tests/test_views.py (16)

    Age stats:
          Youngest PR : 0.0d: 5948: bug 1746872: add note about upload_file_minidum...
       Average PR age : 0.4d
        Median PR age : 0.0d
            Oldest PR : 32.0d: 5802: Bug 1715634 - add get_fpsr to the irrelevant si...

  mozilla-services/antenna:

    Merged PRs: 41


    Committers:
               willkg :    37  ( +3114,  -2744,   55 files)
      dependabot[bot] :     4  (  +219,   -163,    2 files)

                Total :        ( +3333,  -2907,   55 files)

    Most changed files:
      requirements.in (20)
      requirements.txt (20)
      docker/Dockerfile (13)
      antenna/throttler.py (7)
      Makefile (5)
      antenna/app.py (5)
      antenna/breakpad_resource.py (4)
      systemtest/conftest.py (2)
      systemtest/test_dockerflow.py (2)
      antenna/ext/s3/connection.py (2)

    Age stats:
          Youngest PR : 0.0d: 763: fix reqs rules to not load dependencies
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 763: fix reqs rules to not load dependencies

  mozilla-services/tecken:

    Merged PRs: 87

    Committers:
               willkg :    81  (+12635,  -8986,  153 files)
      dependabot[bot] :     6  (   +19,    -19,    4 files)

                Total :        (+12654,  -9005,  153 files)

    Most changed files:
      requirements.in (30)
      requirements.txt (30)
      docker/Dockerfile (18)
      eliot-service/eliot/symbolicate_resource.py (11)
      frontend/yarn.lock (11)
      eliot-service/tests/test_symbolicate_resource.py (9)
      eliot-service/eliot/app.py (7)
      eliot-service/eliot/cache_manager.py (7)
      docs/overview.rst (5)
      Makefile (5)

    Age stats:
          Youngest PR : 0.0d: 2460: Update symbolicate script to use new service
       Average PR age : 0.1d
        Median PR age : 0.0d
            Oldest PR : 3.0d: 2397: bug 1673887: rewrite disk cache manager

  mozilla-services/socorro-submitter:

    Merged PRs: 6

    Committers:
               willkg :     6  (  +908,   -581,   25 files)

                Total :        (  +908,   -581,   25 files)

    Most changed files:
      requirements-dev.txt (4)
      requirements.txt (3)
      src/submitter.py (3)
      docker/test/Dockerfile (2)
      tests/test_submitter.py (1)
      .gitignore (1)
      Makefile (1)
      README.rst (1)
      bin/aws_s3.sh (1)
      bin/build_artifact.sh (1)

    Age stats:
          Youngest PR : 0.0d: 36: Update urllib3
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 36: Update urllib3

  mozilla-services/minidump-stackwalk:
    Closed issues: 11
                               willkg : 2
                       gabrielesvelto : 1

    Merged PRs: 21

    Committers:
               willkg :    10  (  +642,   -354,   14 files)
       gabrielesvelto :     8  (+27998,    -42,  176 files)
               Gankra :     2  (  +188,     -3,    2 files)
       steven-michaud :     1  (  +596,     -0,    2 files)

                Total :        (+29424,   -399,  185 files)

    Most changed files:
      minidump-stackwalk/stackwalker.cc (10)
      README.rst (4)
      bin/build_breakpad.sh (3)
      breakpad-patches/20-winerror-codes.patch (2)
      .gitignore (2)
      bin/run_mdsw.sh (2)
      breakpad-patches/16-get-last-error.patch (2)
      bin/build_stackwalker.sh (2)
      bin/clean_artifacts.sh (2)
      CODE_OF_CONDUCT.md (1)

    Age stats:
          Youngest PR : 0.0d: 47: Readme fixes
       Average PR age : 2.3d
        Median PR age : 0.0d
            Oldest PR : 17.0d: 11: Update breakpad and apply the stackwalker impro...

  willkg/socorro-siggen:
    Closed issues: 5
                               willkg : 1

    Merged PRs: 13

    Committers:
               willkg :    13  (  +946,   -467,   24 files)

                Total :        (  +946,   -467,   24 files)

    Most changed files:
      setup.py (6)
      siggen/cmd_signature.py (6)
      HISTORY.rst (5)
      siggen/__init__.py (4)
      .github/workflows/main.yml (4)
      tox.ini (4)
      siggen/rules.py (4)
      siggen/socorro_sha.txt (4)
      siggen/tests/test_rules.py (4)
      siggen/siglists/prefix_signature_re.txt (3)

    Age stats:
          Youngest PR : 0.0d: 84: Prep for 1.0.8 release
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 84: Prep for 1.0.8 release

  willkg/crashstats-tools:
    Closed issues: 4

    Merged PRs: 9

    Committers:
               willkg :     9  (  +197,   -114,   18 files)

                Total :        (  +197,   -114,   18 files)

    Most changed files:
      setup.py (3)
      .github/workflows/main.yml (3)
      crashstats_tools/utils.py (3)
      src/crashstats_tools/__init__.py (2)
      Makefile (2)
      tox.ini (2)
      crashstats_tools/cmd_reprocess.py (2)
      HISTORY.rst (1)
      README.rst (1)
      src/crashstats_tools/cmd_fetch_data.py (1)

    Age stats:
          Youngest PR : 0.0d: 43: Prep for 1.2.0 release
       Average PR age : 0.0d
        Median PR age : 0.0d
            Oldest PR : 0.0d: 43: Prep for 1.2.0 release


  All repositories:

    Total closed issues: 20
    Total merged PRs: 398
