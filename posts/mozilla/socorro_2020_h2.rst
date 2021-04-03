.. title: Socorro Engineering: Half in Review 2020 h2 and 2020 retrospective
.. slug: socorro_2020_h2
.. date: 2021-01-14 10:00
.. tags: mozilla, work, socorro, tecken, dev


Summary
=======

2020h1 was rough. 2020h2 was also rough: more layoffs, 2 re-orgs, Covid-19.

I (and Socorro and Tecken) got re-orged into the Data Org. Data Org manages the
Telemetry ingestion pipeline as well as all the things related to it. There's a
lot of overlap between Socorro and Telemetry and being in the Data Org might
help reduce that overlap and ease maintenance.

But this post isn't about the future--it's about the past! Let's talk about
what happened in 2020h2 and then a brief retrospective of 2020.

Prepare to dive in!

.. TEASER_END

Highlights of 2020h2
====================

* **Socorro: Massive update to socorro-submitter**

  The socorro-submitter is part of our test infrastructure. It mimics incoming
  crash reports sent to the collector. It hadn't been updated in a long while,
  so it didn't support changes to crash report payloads we've made over the
  last few years.

  The massive update fixes holes in test in our staging environment.

* **Socorro: Redid infrastructure for minidump-stackwalk**

  The Socorro processor takes a minidump and runs the stackwalker which
  extracts information from the minidump. Mozilla has multiple stackwalkers and
  while they all use the Breakpad library, they use different versions of the
  Breakpad library and in some cases, have different patch sets.

  Extracting minidump-stackwalk into a separate repository makes it easier for
  other people to help maintain it, apply patches, and test changes. Further,
  it now has its own release infrastructure, so we can tag versions of
  minidump-stackwalk and push those to the cloud. When we build Socorro, we now
  pull those pre-built binaries--this reduced Socorro build times.

  I also did a round of optimizing minidump-stackwalk builds including
  generating PGO profiles. Gabriele vastly improved that work so it builds the
  profiles as part of the build. That improved stackwalking runtimes slightly.

* **Socorro: Redid Crash Stats product support**

  Prior to Fenix, Socorro and Crash Stats supported multiple products, but they
  were all kind of the same in regards to their needs and build infrastructure.
  Fenix is really different, so to support it and other
  GeckoView/android-components-using Android apps we had to make significant
  changes to the assumptions Socorro makes when processing and displaying those
  crash reports. I lump this flexibility into "product support".

  In 2020h2, we hit a series of requirements that forced me to redo product
  support. Now it's a set of JSON files in the ``product_details/`` directory.
  Each JSON file covers a single product. All the product-specific
  configuration is now in that file.

  For example, we can now set the create-a-bug links on a product-by-product
  basis. Fenix now has create-a-bug links for a variety of GitHub issue
  trackers as well as Bugzilla components.

  Anyone can submit a PR to add, remove, or modify the create-a-bug links for a
  product.

* **Socorro: Overhauled protected data policy**

  I worked with Alicia and others to fix the language around protected data,
  overhaul the protected data policy, and add some tooling to make it easier to
  grant, audit, and revoke protected data access.

  It's much clearer, the term "protected data" is now used consistently across
  the site, and there should be less confusion about how it all works.

  Later in the half, I sent an email to everyone who has protected data access
  reminding them of the policy details and where they can find it. 

  The proected data policy is here:
  https://crash-stats.mozilla.org/documentation/protected_data_access/

* **Socorro: Documented process for adding crash annotations**

  Crash annotations are the key/value pairs of metadata that get added to crash
  reports.  Socorro exists in a larger ecosystem of crash data and some crash
  annotations flow between systems, while others don't. Also, it was not clear
  how to add a crash annotation and make sure it can be searchable, it shows up
  in crash ping data, and it shows up in the socorro_crash data set in
  Telemetry.

  Documenting this clarifies everything. Further, it codifies how crash
  annotations fit in with Mozilla data collection practices and moves us one
  step towards unifying crash data with the rest of the data that Data Org
  manages.

  The documentation for adding crash annotations is here:
  https://socorro.readthedocs.io/en/latest/annotations.html

* **Socorro: Raised the max body size for incoming crash report payloads**

  Previously, crash report payloads have to be under 10mb. If they were over,
  the crash report was rejected.

  We have metrics around crash report payload sizes. Here's what we're seeing
  today:

  * 50%: 220kb
  * mean: 330kb
  * 95%: 1.5mb

  It's rare we have crash reports that exceed 10mb. However, there are
  scenarios where the resulting crash reports do exceed 10mb like stack
  overflow errors.

  In 2020h2, we raised the max payload size to 25mb. That didn't seem to affect
  the number of rejected crash reports because of payload size much. It did
  seem to increase the number of connection timeouts when POSTing crash report
  payloads.

  Fennec compresses crash reports because they could be sent over mobile data
  and that's expensive for users. Fenix and other products that use
  android-components also compress crash reports. Firefox desktop, however,
  does not. 

  We decided the next step is to compress Firefox crash reports. :bz:`781630`
  covers that. After that work is done, we'll see where we're at again.

* **Socorro: Crash Stats .COM to .ORG**

  Some Mozilla properties are on a .ORG domain and some are on a .COM domain.
  Some were on a .COM domain and transitioned to .ORG. We started to transition
  Crash Stats from .COM to .ORG a long time ago, but never did the next step.
  We did that this half. Now all crash-stats.mozilla.com requests are
  redirected to crash-stats.mozilla.org.

  This *ONLY* covers Crash Stats--the site where you analyze crash reports.
  This does not affect where crash reports get sent.

* **Socorro: Breadcrumbs for Fenix**

  In 2020h2, Roger and I worked out a structure for sending breadcrumbs data
  with Fenix crash reports as a Crash Annotation. We cribbed from the format
  that Sentry uses. That went through a couple of rounds of honing and the data
  review process and then landed.

  Next step is to add some code to make the breadcrumbs data for crash reports
  viewable on Crash Stats. [1]_

  .. [1] NB: I got to that this week! It's considered protected data, so if you have
     access to protected data, you can see it. Example crash report:
     https://crash-stats.mozilla.org/report/index/e1bb8ccc-de3a-4891-b0dd-f1ca40210114

* **Socorro: Structured JavaException**

  For the last 10 years, we've had mediocre support for crash reports in
  Java-land. One of the consequences of this is that we have terrible
  signatures for Java crash reports. Crash reports get an unstructured
  ``JavaStackTrace`` annotation which is junk to parse.

  We really needed structured data to generate signatures and also to show
  stack trace breakdown with links to source code and other stuff.

  In 2020h2, I worked with Roger to establish a structured format for Java
  exceptions. We cribbed from the format that Sentry uses. That went through
  honing and data review and it's now in the ``JavaException`` crash
  annotation.

  In 2021, I'll work on showing that information in the Details page of the
  crash report. This is covered in :bz:`1675560`.

  In 2021, I'll also implement better signature generation for Java crash
  reports. This is covered in :bz:`1541120`.

* **Tecken: Clean up database tables**

  Tecken had a bunch of database tables that were monotonically increasing in
  size despite the fact that they contained metadata about things that had
  expired. I implemented table cleanup routines and we ran them and that
  deleted over half of the data and sped up the site.

* **Tecken: Rewrote API documentation**

  I rewrote the Tecken API documentation so it's clearer how to use it to
  upload symbols, download symbols, and do symbolication.

  https://tecken.readthedocs.io/en/latest/index.html

* **Tecken: dll/exe compression problem**

  We (Mozilla) have been adjusting the build system to reduce build times for
  Firefox. One of the recent steps was to move the uploading-symbols step to a
  later part of the build. When that happened, it stopped compressing dll and
  exe files when uploading them to Tecken. Then Tecken wouldn't serve them.

  I helped figure that out, suggested a fix, and then fixed all the dll/exe
  data we had accumulated.

* **Tecken: move admin-y things to Django admin pages**

  Tecken has a React frontend and a bunch of admin-y pages written using it.
  That's fine, but Tecken is built on Django and Django has admin pages built
  in and it's much easier to enable Django admin pages for db tables than it is
  to build an API and React pages to use that API.

  I enabled the Django admin and moved a bunch of functionality from React to
  the Django admin simplifying administration and maintenance.

* **Tecken: rewrite symbolication API as a new microservice (started)**

  The Tecken symbolication API runs in the same service as symbols uploading
  and downloading. That's a problem because uploading symbols is critical and
  when we're getting bursts of symbolication API requests, that can block
  uploading symbols.

  On top of that, we want to add line numbers to symbolication results and we
  want to start paving the road towards Rust-ified Breakpad libraries and
  ditching the SYM format which doesn't support inline functions well.

  I wrote a new symbolication API that runs as a separate microservice. It uses
  the `Symbolic <https://github.com/getsentry/symbolic>`_ library that Sentry
  maintains to parse SYM files and lookup symbols. It supports line numbers,
  parsing other debug formats, and a bunch of other stuff.

  This is only half done because I hit a couple of blockers. I hope to finish
  up this work in 2021.


I also did a bunch of small features, signature generation changes,
reprocessing, bug fixes, docs fixes, and other things.


Retrospective for 2020
======================

2020 sucked. At the end, I was feeling completely demoralized and deflated.
Looking back, seems like I still managed to move some big things forward:

* **Fixing protected data policy things**

  This is in much better shape now. It uses consistent language, it's better
  structured, it's clearer, and it's easier to maintain going forward.

* **minidump-stackwalk as a separate project**

  This is big step towards unifying the myriad of stackwalkers at Mozilla and
  Rust-ifying everything.

* **Breadcrumbs for Fenix**

  Anything we can do to make it easier to figure out causes for crashes for
  Fenix is a win.

  I just landed this. Yay!

* **Signatures for Java crash reports**

  This has been requested for a long time and it'll be great to finally have
  it.

  Hopefully, I'll have a first pass for early 2021.

* **Documentation and specifications**

  I wrote the specification for requesting new crash annotations that covers
  all the places that crash data ends up. Until that point, there hadn't been
  one and adding crash annotations was haphazard at best.

  I documented all the Tecken APIs which then made it possible to know what
  requirements needed testing in a Tecken systemtest.

* **Maintenance improvements**

  I spent quality time fixing test issues, vastly improving documentation,
  improving tools, and cleaning up project scaffolding so it's consistent
  across all the Socorro-verse projects and easier to maintain for one person.

* **Separate symbolication API microservice**

  This will make it possible for us to symbolicate the stacks in the crash ping
  data set which then lets us generate signatures for that data. Plus it fixes
  some issues for the Firefox profiler and other projects.

  Hopefully, I'll be able to finish this in early 2021.

* **Auditing projects**

  In early 2020, I finally wrote a blog post covering how to audit a project
  that just got dumped in your lap.

  I wanted to take that process and also create a rapid audit review (RAR!)
  that's like the RRA that secops has. The thinking being that you get a bunch
  of people in a room, hash out some questions over 30-60 minutes and then have
  a good idea of the lay of the land for a project and next steps for moving
  forward with it.

  I never got to doing that, but maybe I'll write it up in 2021.


So 2020 was rough and disappointing and demoralizing and all that, but I think
I've got some big wins queued up for early 2021.
