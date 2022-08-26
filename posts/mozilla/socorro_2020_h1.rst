.. title: Socorro Engineering: Half in Review 2020 h1
.. slug: socorro_2020_h1
.. date: 2020-09-11 10:00
.. tags: mozilla, work, socorro, tecken


Summary
=======

2020h1 was rough. Layoffs, re-org, Berlin All Hands, Covid-19, focused on MLS
for a while, then I switched back to Socorro/Tecken full time, then virtual All
Hands.

It's September now and 2020h1 ended a long time ago, but I'm only just getting
a chance to catch up and some things happened in 2020h1 that are important
to divulge and we don't tell anyone about Socorro events via any other medium.

Prepare to dive in!

.. TEASER_END

Highlights of 2020h1
====================

Here's highlights of 2020h1:

* **Switch to dependabot for dependency management**

  We had problems with the system we were using and decided to go whole hog
  and switch to dependabot for all dependency management.

  One problem with this is that dependabot creates one pull request per
  dependency update. So on the first of the month, we get a bazillion pull
  requests. Multiply this by multiple repositories and projects and that
  becomes a ton of work to do every month.

  I wrote a tool called `paul-mclendahand <https://github.com/willkg/paul-mclendahand/>`_
  to deal with this. 

  Blog post: :doc:`pyup_to_dependabot`

* **Switch from GCP Pub/Sub to AWS SQS for queueing**

  I did the bulk of this work at the end of 2019, but in early 2020, we did
  the switch.

  Tracker bug: https://bugzilla.mozilla.org/show_bug.cgi?id=1583930

* **Socorro 3-year Roadmap**

  I spent a good chunk of 2020h1 looking at the current state of Socorro and
  Tecken, what they do, why they do it, similar projects at Mozilla, and
  finally where we should head over the next 3 years.

  For Tecken, there's a lot of overlap between Tecken and what Sentry is
  working on around symbols and symbolication. We should unify these two
  efforts where possible. The first step towards this is switching to use the
  `Symbolic library <https://github.com/getsentry/symbolic>`_.

  For Socorro, the story is a little different. Mozilla has multiple data
  ingestion pipelines. Each pipeline solves the same set of problems:

  1. client to send data to the pipeline
  2. pipeline with the same rough shape: collector, processor, data storage,
     access to data, reports, ad hoc analysis tools
  3. data policy
  4. data steward group enforcing the data policy
  5. process for getting access to data and people responsible for handling
     access requests
  6. process for removing data and handling data removal requests
  7. documentation
  8. support for groups adding data and using data

  There's a lot of overlap. Further, for Socorro, all those things were covered
  by John and I. For other ingestion pipelines, there are tens of people
  covering those things.

  Thus the roadmap for Socorro is to unify as many of those things with the
  Data Platform group's versions and reduce a lot of redundancy, specialized
  tooling, maintenance costs, and other things.

* **Fenix support**

  We did a lot of work on Socorro to support Fenix requirements. Some of that
  work has benefited Fennec and other projects as well. Socorro is in a much
  better place for supporting projects that work differently than Firefox does.

  Socorro handles semver versions now in addition to the "Firefox version
  scheme".

  Tracker bug: https://bugzilla.mozilla.org/show_bug.cgi?id=1625194

* **Improved product support documentation**

  As part of improving Fenix support, we changed a bunch of things around
  how Socorro supports products and the documentation for that.

  Docs: https://socorro.readthedocs.io/en/latest/products.html

* **Switch from master to main**

  We switched all the repositories related to Tecken and Socorro to use "main"
  as the default branch name.

* **Improved language and notices around protected data**

  Prior to this work, we talked about data as "public" and "requiring minidump
  access" which made sense a long time ago, but makes no sense now. Now we've
  got "public" and "protected data". Also, we used different phrases in
  different places like "minidump access" and "personally identifiable
  information".

  Further, when you were logged in and had access to protected data, it was
  unclear which data protected and which was public.

  Even further, when you were logged in and didn't have access to protected
  data, it was unclear what you couldn't see and what you could do about that.

  I standardized everything to use the phrase "protected data". I cleaned up
  the data policy. I added notes to web pages stating whether you were seeing
  or not seeing protected data with links to the policy. I improved the
  iconography around protected data.

  If you see things that are still confusing, please let me know.

  Bug: https://bugzilla.mozilla.org/show_bug.cgi?id=1611131

* **Improved documentation for crash annotations**

  Crash reports consists of a set of crash annotations and then zero or more
  minidump files. I documented crash annotations, what they are, where they're
  documented, and the process to add them.

  Docs: https://socorro.readthedocs.io/en/latest/annotations.html

* **Wrote systemtest for Tecken**

  In 2019, I had cobbled together a "system test" for Tecken to verify that the
  APIs were working in a live system, but the number of issues were increasing
  and it effectively stopped working.

  I wrote a new system test which effectively tests live environments. I based
  some bits on the Antenna system test I wrote years ago.

  The Tecken system test also has a set of utilities for manipulating stacks
  and generating test data which is handy for debugging issues.

  Bug: https://bugzilla.mozilla.org/show_bug.cgi?id=1618942


We also did a bunch of small features, bug fixes, docs fixes, and other things.


Summarized Bugzilla and GitHub stats for 2020h1
===============================================

Stats from GitHub and Bugzilla for the period in question.

::

    Period (2020-01-01 -> 2020-06-30)
    =================================
    
    Bugzilla
    ========
    
      Bugs created: 184
      Creators: 34
    
           Will Kahn-Greene [:willkg] ET  : 128
           Gabriele Svelto [:gsvelto] (PT : 12
                              Brian Pitts : 6
                Andrew McCreight [:mccr8] : 3
            Simon Giesecke [:sg] [he/him] : 3
                    Michael Froman [:mjf] : 2
                 Markus Stange [:mstange] : 2
                Kevin Brosnan [:kbrosnan] : 2
           Andrew Sutherland [:asuth] (he : 1
                                 and more ...
    
      Bugs resolved: 205
    
                                  WONTFIX : 17
                                 INACTIVE : 5
                                    FIXED : 173
                               INCOMPLETE : 2
                               WORKSFORME : 1
                                  INVALID : 2
                                DUPLICATE : 2
    
      Resolvers: 11
    
           Will Kahn-Greene [:willkg] ET  : 179
                              Brian Pitts : 16
           Gabriele Svelto [:gsvelto] (PT : 3
                Andrew McCreight [:mccr8] : 2
                 Markus Stange [:mstange] : 2
               Calixte Denizet (:calixte) : 1
               Peter Bengtsson [:peterbe] : 1
           Miles Crabill [:miles] [also m : 1
    
      Commenters: 83
    
                                   willkg : 993
                                   bpitts : 57
                                  peterbe : 56
                                  gsvelto : 55
                                    miles : 34
                            mcastelluccio : 17
                                   adrian : 16
                             orangefactor : 14
                             chris.lonnen : 10
                             continuation : 10
                                 and more ...
    
      Tracker bugs: 2
    
          1583930: [tracker] switch from pubsub to aws sqs
          1625194: [tracker] support fenix
    
      Statistics
    
          Youngest bug : 0.0d: 1607369: switch to dependabot (socorro)
       Average bug age : 231.3d
        Median bug age : 13.0d
            Oldest bug : 2311.0d: 951299: Crashes by build date should be segregated by c...
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 152
    
        * 5447: bug 1645442: switch master to main (willkg)
        * 5446: Bump Fennec version to 68.10.0 (jcristau)
        * 5445: bug 1646675: add FindElementCommon to prefix list (willkg)
        * 5444: bug 1644234: add libart.so to prefix list (willkg)
        * 5443: Update release to latest version (willkg)
        * 5442: bug 1497353: make telemetry_environment not searchable (willkg)
        * 5441: bug 1624345: stop saving random data to elasticsearch crashstorage (willkg)
        * 5438: Update Django to 2.2.13 (willkg)
        * 5440: bug 1497353: remove not_analyzed fields (willkg)
        * 5439: Modify Fenix feature versions (rocketsroger)
        * 5437: Updates 20200602 2 (willkg)
        * 5432: Updates 20200602 (willkg)
        * 5431: Update Fennec to 68.9.0 (pascalchevrel)
        * 5429: bug 1611131: improve language around protected data and access (willkg)
        * 5430: bug 1611131: fix protected-info css (willkg)
        * 5402: bug 1640942: improve rust OOM signatures (willkg)
        * 5403: bug 1641316: fix bugzilla bug creation for java errors (willkg)
        * 5400: Update Fennec release version to 68.8.1 (rvandermeulen)
        * 5399: bug 1616718: add logging for when the BZAPI_TOKEN isn't used (willkg)
        * 5398: Remove "object" superclass (willkg)
        * 5396: bug 1630968: remove deprecated monitoring endpoints (willkg)
        * 5397: Modify Fenix feature versions (rocketsroger)
        * 5395: bug 1616718: fix code to use bugzilla api token if available (willkg)
        * 5394: bug 1619962: rework deletion scripts to use click and add basic test (willkg)
        * 5391: bug 1625515: redo version parsing and sorting (willkg)
        * 5393: bug 1608873: switch from hg annotate to hg file link (willkg)
        * 5392: Add core::option::expect_none_failed to the prefix list (jrmuizel)
        * 5390: bug 1633501: remove vestigal user_id bits in processor (willkg)
        * 5389: bug 1409547: add basic test for sqs_cli.py script (willkg)
        * 5388: bug 1622932: explicitly exclude "1024" version (willkg)
        * 5387: Update Fennec release version to 68.8.0 (rvandermeulen)
        * 5386: bug 1633473: add pthread_mutex_trylock to prefix list (willkg)
        * 5385: Updates 20200501 (willkg)
        * 5359: bug 1383113: switch mozilla processor rules to getitem notation (willkg)
        * 5358: bug 1383113: clean up memory_report_extraction rules tests (willkg)
        * 5357: bug 1383113: remove DotDict usage in breakpad rules (willkg)
        * 5356: bug 1383113: switch to getitem notation for general rules (willkg)
        * 5354: bug 1054508: add warning to raw crash data and minidumps section (willkg)
        * 5355: bug 1383113: switch from getattr to getitem notation in breakpad rules (willkg)
        * 5353: bug 1621094: remove debug view link in admin (willkg)
        * 5351: bug 1409547: add basic tests to scripts (willkg)
        * 5352: bug 1621094: remove debug admin view (willkg)
        * 5350: bug 1626632: rewrite validate_and_test with click and add basic test (willkg)
        * 5349: bug 1620595: add annotations documentation (willkg)
        * 5348: Update markus to 2.2.0 (willkg)
        * 5347: bug 1626048: add SubmittedFromInfobarFixRule to pipeline (willkg)
        * 5346: Update minimist to 1.2.3 or later (willkg)
        * 5345: bug 1629854: add core::result::unwrap_failed to prefix list (willkg)
        * 5341: bug 1626245 - Surface Linux LSB release information provided in the format used by Debian/Fedora (gabrielesvelto)
        * 5343: bug 1628311: fix scripts/run_mdsw.sh (willkg)
        * 5342: bug 1622871: add basic docs for correlations (willkg)
        * 5340: bug 1626801: add RpcpRaiseException to prefix list (willkg)
        * 5339: Updates 20200406 2 (willkg)
        * 5338: bug 1622976: clarify that fields to add should be documented (willkg)
        * 5337: bug 1626048: fix SubmittedFromInfobar values (willkg)
        * 5332: Updates 20200406 (willkg)
        * 5330: bug 1626801: move CxxThrowException to prefix list (willkg)
        * 5331: Update fennec versions (jcristau)
        * 5329: bug 1626801: add CxxThrowException and friends to sig lists (willkg)
        * 5328: bug 1610568: add collector_notes to supersearch and report index (willkg)
        * 5327: bug 1625039: add dom_fission_enabled to crash report schema (willkg)
        * 5326: bug 1626618: change BetaVersionRule to only work on supported products (willkg)
        * 5325: bug 1626032: fix validate_and_test script (willkg)
        * 5302: bug 1622976: first pass at socorro -> telemetry docs (willkg)
        * 5301: Modify Fenix feature versions (rocketsroger)
        * 5294: Add Fenix feature verions (rocketsroger)
        * 5300: bug 1624870: improve product support docs and tips (willkg)
        * 5299: bug 1624911: change Fenix nightly versions from "Nightly..." to "0.0a1" (willkg)
        * 5298: bug 1625154: fix updatemissing to work across date bounds (willkg)
        * 5297: bug 1624403: fix case where URLError has no code (willkg)
        * 5296: bug 1624403: switch SQS check to use waitfor script (willkg)
        * 5295: bug 1619638: remove java_stack_trace_full before indexing in Elasticsearch (willkg)
        * 5293: bug 1624790: add "syscall" to prefix list (willkg)
        * 5292: bug 1624403: fix bucket and queue names (willkg)
        * 5291: Update to CircleCI config 2.1 (willkg)
        * 5290: bug 1624403: reduce localstack containers (willkg)
        * 5289: bug 1596106: security fixes (willkg)
        * 5287: bug 1622932: fix featured versions (willkg)
        * 5288: Switch Slack links to Matrix links (willkg)
        * 5286: bug 1608116: add DeNoneRule (willkg)
        * 5285: bug 1607519: fix JavaStackTrace parsing (willkg)
        * 5284: bug 1623064: rework save_processed and save_raw_and_processed (willkg)
        * 5283: bug 1619646: add handling for UnicodeEncodeError in truncating (willkg)
        * 5282: Update acorn to 5.7.4 (willkg)
        * 5281: Nit: Change "py.test" to "pytest" (willkg)
        * 5280: Update deps 20200312 2 (willkg)
        * 5269: Update deps 20200312 (willkg)
        * 5268: Update documentation (willkg)
        * 5267: bug 1618201: remove pubsub things (willkg)
        * 5266: Update Fennec versions for 68.6 release (jcristau)
        * 5265: bug 1619962: crash report deletion script (willkg)
        * 5264: bug 1619606: add mozilla::CheckCheckedUnsafePtrs<T>::Check to prefix list (willkg)
        * 5226: Improve graphics device data flow docs (willkg)
        * 5225: bug 1617911: improve tools for fixing crash report data (willkg)
        * 5223: bug 1616194: use json_dump.lsb_release.description for platform pretty version (willkg)
        * 5224: bug 1617918: fix IPC Channel Error signature generation rule (willkg)
        * 5222: bug 1616837: add RustMozCrash to irrelevant list (willkg)
        * 5221: bug 1612569: update signature generation docs (willkg)
        * 5220: bug 1612569: fix SignatureIPCChannelError docstring (willkg)
        * 5219: bug 1616253: fix aggregation for ipc_shutdown_state (willkg)
        * 5218: Update Fennec versions for new releases (rvandermeulen)
        * 5217: bug 1614033: switch to unittest.mock (willkg)
        * 5216: bug 1612569: improve ShutDownKill signatures (willkg)
        * 5215: Bug 1612921 - Add some CString functions to the prefix list (willkg)
        * 5211: update dependencies: 20200205 (willkg)
        * 5208: update dependencies: 20200204 (willkg)
        * 5172: Add servo_arc::Arc<T>::drop_slow to the prefix list (jrmuizel)
        * 5205: Update Django to 2.2.10 (willkg)
        * 5207: bug 1612924: update breakpad to 216cea7bca53fa441a3ee0d0f5fd339a3a894224 (willkg)
        * 5170: bug 1610520: listing and removing data from S3 and Elasticsearch (willkg)
        * 5171: bug 1610792: add mozilla::DOMEventTargetHelper::AddRef to prefix list (willkg)
        * 5169: bug 1610249: switch . to : in chown calls (willkg)
        * 5167: bug 1608111: add single JSON-encoded value bits to specification (willkg)
        * 5168: Bump the Fennec release version to 68.4.2 (rvandermeulen)
        * 5166: bug 1609247: move __security_check_cookie to irrelevant list (willkg)
        * 5165: bug 1608111: initial crash report v0 specification (willkg)
        * 5164: Bug 1609247 - Add _security_check_cookie to the irrelevant signatures… (amccreight)
        * 5163: bug 1608870: added mozilla::ipc::Shmem items to prefix list (willkg)
        * 5162: bug 1609121: add __pthread_cond_wait to prefix list (willkg)
        * 5160: dependency updates round 5 (willkg)
        * 5158: update dependencies round 4 (willkg)
        * 5156: python updates round 3 (willkg)
        * 5155: python updates round 2 (willkg)
        * 5151: update python dependencies (willkg)
        * 5149: bug 1607806: fix converting ModuleSignatureInfo values (willkg)
        * 5148: bug 1607806: make ModuleSignatureInfo always a JSON-encoded string (willkg)
        * 5147: Bump Fennec release version to 68.4.1 (rvandermeulen)
        * 5146: bug 1607519: fix Caused By handling in java stack trace parser (willkg)
        * 5083: bug 1607369: switch to dependabot and remove pyup configuration (willkg)
        * 5084: Update Fennec versions (rvandermeulen)
        * 5082: bug 1581927: fix cronrun to run jobs despite OngoingJobError (willkg)
        * 5081: bug 1605429: fix stackwalker to work with ModuleSignatureInfo as object (willkg)
        * 5080: bug 1543767: fix topcrashers summary line (willkg)
        * 5079: bug 1605806: fix language around requesting pii access (willkg)
        * 5078: bug 1552976: fix correlations tab (willkg)
        * 5077: Update Python to 3.7.6 and update dependencies (willkg)
    
        Committers:
                   willkg :   118  ( +6353,  -5788,  210 files)
          dependabot-prev :    15  (   +52,    -52,    3 files)
            rvandermeulen :     6  (    +6,     -6,    1 files)
             rocketsroger :     4  (    +6,     -3,    1 files)
                 jcristau :     3  (    +3,     -3,    1 files)
                 jrmuizel :     2  (    +2,     -0,    1 files)
            pascalchevrel :     1  (    +1,     -1,    1 files)
          dependabot[bot] :     1  (    +4,     -4,    2 files)
           gabrielesvelto :     1  (   +11,     -5,    1 files)
               amccreight :     1  (    +1,     -0,    1 files)
    
                    Total :        ( +6439,  -5862,  213 files)
    
        Most changed files:
          requirements/constraints.txt (29)
          requirements/default.txt (20)
          socorro/signature/siglists/prefix_signature_re.txt (18)
          docs/requirements.txt (13)
          product_details/FennecAndroid.json (10)
          socorro/unittest/processor/rules/test_mozilla.py (9)
          socorro/processor/rules/mozilla.py (8)
          docs/index.rst (8)
          socorro/unittest/external/es/test_crashstorage.py (7)
          webapp-django/crashstats/settings/base.py (6)
    
        Age stats:
              Youngest PR : 0.0d: 5447: bug 1645442: switch master to main
           Average PR age : 0.2d
            Median PR age : 0.0d
                Oldest PR : 6.0d: 5341: bug 1626245 - Surface Linux LSB release informa...
    
      mozilla-services/antenna:
    
        Merged PRs: 70
    
        * 561: bug 1645444: switch from master to main (willkg)
        * 560: Update release to latest version (willkg)
        * 559: Updates 20200602 2 (willkg)
        * 555: Updates 20200602 (willkg)
        * 534: bug 1513020: reject incoming crash reports with build id > 2 years (willkg)
        * 533: Updates 20200501 2 (willkg)
        * 529: Updates 20200501 (willkg)
        * 507: Updates 20200402 2 (willkg)
        * 504: Updates 20200402 (willkg)
        * 492: Update to CircleCI config 2.1 (willkg)
        * 491: bug 1624949: throttle ShutDownKill crash reports (willkg)
        * 489: bug 1624033: remove throttle rules for thunderbird and seamonkey (willkg)
        * 490: bug 1619644: handle None values in throttler (willkg)
        * 488: Update deps 20200316 2 (willkg)
        * 483: Update deps 20200316 (willkg)
        * 482: bug 1618201: fix gunicorn worker class to be configurable (willkg)
        * 481: Clean up documentation (willkg)
        * 480: bug 1619101: change seamonkey throttle rule to gt 2.53.2 (willkg)
        * 478: bug 1618201: remove pubsub code (willkg)
        * 477: bug 1619101: update seamonkey filter to 2.53.1 (willkg)
        * 447: bug 1617911: add TelemetrySessionId to BAD_FIELDS list (willkg)
        * 446: bug 1614985: handle JSONDecodeError in json value (willkg)
        * 445: update dependencies: 20200203 (willkg)
        * 422: bug 1610540: add code for removing fields (willkg)
        * 420: bug 1604848: reject incoming thunderbird > 68 and seamonkey > 2.49.5 (willkg)
        * 421: bug 1609440: distinguish between rejections (willkg)
        * 419: bug 1608104: add note about annotations in crash report (willkg)
        * 418: Update test data container (willkg)
        * 413: bug 1606763: fix location of Dockerfiles (willkg)
        * 417: Add urlwait calls to docker/run_setup.sh (willkg)
        * 412: bug 1606763: remove pyup configuration (willkg)
        * 375: bug 1606763: switch to dependabot (willkg)
        * 374: Update Python to 3.7.6 and default dependencies (willkg)
    
        Committers:
          dependabot-prev :    37  (  +270,   -258,    4 files)
                   willkg :    33  ( +1469,  -1903,   44 files)
    
                    Total :        ( +1739,  -2161,   44 files)
    
        Most changed files:
          requirements/constraints.txt (39)
          requirements/default.txt (15)
          antenna/throttler.py (7)
          tests/unittest/test_throttler.py (7)
          docker/Dockerfile (6)
          antenna/breakpad_resource.py (6)
          setup.cfg (3)
          docker/Dockerfile.pubsub (3)
          docker/run_tests_in_docker.sh (3)
          tests/unittest/test_breakpad_resource.py (3)
    
        Age stats:
              Youngest PR : 0.0d: 561: bug 1645444: switch from master to main
           Average PR age : 0.1d
            Median PR age : 0.0d
                Oldest PR : 3.0d: 420: bug 1604848: reject incoming thunderbird > 68 a...
    
      mozilla-services/tecken:
        Closed issues: 1
    
        Merged PRs: 46
    
        * 2104: bug 1645443: switch from master to main (willkg)
        * 2105: Update readme (willkg)
        * 2106: bug 1645443: fix circle config (willkg)
        * 2103: Update release to latest version (willkg)
        * 2102: bug 1627052: fix table of contents (willkg)
        * 2101: bug 1627052: rewrite symbolication API docs (willkg)
        * 2096: Update django to 2.2.13 (willkg)
        * 2098: Rebuild yarn.lock (willkg)
        * 2099: Fix error in error handling in download-missing-symbols script (willkg)
        * 2100: bug 1646133: switch to better language (willkg)
        * 2095: Add note about redis==3.4.1 (willkg)
        * 2094: Updates 20200602 2 (willkg)
        * 2089: Updates 20200602 (willkg)
        * 2088: bug 1641212: add missingsymbols.csv systemtest (willkg)
        * 2087: bug 1641212: remove intermediary downloads listing page (willkg)
        * 2057: bug 1641212: remove "download_from_microsoft" code (willkg)
        * 2056: Updates 20200501 2 (willkg)
        * 2032: bug 1634372: fix make-stacks to handle unknown frames (willkg)
        * 2053: Updates 20200501 (willkg)
        * 2031: bug 1556775: add S3 bucket creation to "make setup" (willkg)
        * 2030: bug 1596109: fix ACAO header with static assets (willkg)
        * 2029: bug 1552947: remove credentials argument (willkg)
        * 2028: Update markus to v2.2.0 (willkg)
        * 2027: bug 1630120: fix frontend in local dev environment (willkg)
        * 2026: bug 1628802: fix permissions issues in docker containers (willkg)
        * 2025: Updates 20200414 2 (willkg)
        * 2018: Updates 20200414 (willkg)
        * 2019: Fix prettier run in circleci (willkg)
        * 2016: bug 1618942: add upload system tests (willkg)
        * 2017: Update kind-of to 6.0.3 or later (willkg)
        * 2015: bug 1618942: add system test for symbolicate api and downloading sym files (willkg)
        * 1990: Update to CircleCI config 2.1 (willkg)
        * 1989: Update acorn to 7.1.1 and minimist to 1.2.5 (willkg)
        * 1964: minor cleanup of scaffolding (willkg)
        * 1962: update dependencies: 2020-02-03 (willkg)
        * 1961: Update Django 2.2.10 (willkg)
        * 1938: update dependencies 20200114 (willkg)
        * 1914: bug 1607492: add dependabot configuration (willkg)
        * 1913: bug 1607492: switch to dependabot (willkg)
        * 1912: Update to Python 3.7.6, update python dependencies, move some things around (willkg)
    
        Committers:
                   willkg :    40  (+11591, -11911,  104 files)
            renovate[bot] :     4  (    +9,     -9,    6 files)
          dependabot-prev :     2  (    +6,     -6,    2 files)
    
                    Total :        (+11606, -11926,  106 files)
    
        Most changed files:
          requirements/default.txt (16)
          frontend/yarn.lock (10)
          requirements/constraints.txt (10)
          docker/Dockerfile (9)
          frontend/package.json (9)
          frontend/Dockerfile (7)
          .circleci/config.yml (6)
          requirements/docs.txt (6)
          frontend/src/Home.js (5)
          tecken/settings.py (4)
    
        Age stats:
              Youngest PR : 0.0d: 2104: bug 1645443: switch from master to main
           Average PR age : 0.2d
            Median PR age : 0.0d
                Oldest PR : 2.0d: 1941: Update python:3.7.6-slim-stretch Docker digest ...
    
    
      All repositories:
    
        Total closed issues: 1
        Total merged PRs: 268
