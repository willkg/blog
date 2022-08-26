.. title: Socorro: April 2019 happenings
.. slug: socorro_2019_04
.. date: 2019-05-02 06:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

This blog post summarizes Socorro activities in April.


.. TEASER_END

Staff in April
==============

Me... And then John joined mid-April so now there are two of us!


Highlights of April
===================

* Onboarded John. Reviewed, improved, and fixed documentation and local dev
  environment.

* Took over 5 additional projects. Now this team covers the following:

  * Socorro aka Crash Stats aka crash-stats.mozilla.com
  * Tecken aka symbols.mozilla.org
  * Buildhub2
  * Buildhub
  * PollBot
  * Delivery Dashboard

  We're still ramping up on all of them. If you need anything, let us know.

  This also made me overhaul my ``in_review.py`` script to support GitHub
  issues.

* Decommissioned Pigeon.

* Replaced Crontabber with a Django command that can run arbitrary Django
  commands. This model fits our current and future architecture better.


Bugzilla and GitHub stats for April
===================================

::

    Bugzilla
    ========
    
      Bugs created: 70
      Creators: 18
    
           Will Kahn-Greene [:willkg] ET  : 41
           Kartikaya Gupta (email:kats@mo : 4
               John Whitlock [:jwhitlock] : 4
           Marcia Knous [:marcia - needin : 3
           Liz Henry (:lizzard) (use need : 2
                        Jan Varga [:janv] : 2
                  Mike Hommey [:glandium] : 2
              Andrew Overholt [:overholt] : 2
                      Nico Grunbaum [:ng] : 1
                  Kevin Jacobs [:kjacobs] : 1
                               [:philipp] : 1
                Andrew McCreight [:mccr8] : 1
            Alex Chronopoulos [:achronop] : 1
           Bogdan Maris [:bogdan_maris],  : 1
                  Stefan Arentz [:st3fan] : 1
           Dana Keeler (she/her) (use nee : 1
                    Jon Coppeard (:jonco) : 1
               Jeff Muizelaar [:jrmuizel] : 1
    
      Bugs resolved: 66
    
                                  INVALID : 1
                                    FIXED : 56
                                  WONTFIX : 7
                                DUPLICATE : 1
                               WORKSFORME : 1
    
      Resolvers: 11
    
           Will Kahn-Greene [:willkg] ET  : 52
               John Whitlock [:jwhitlock] : 6
                                   Lonnen : 1
                                   Osmose : 1
              Kartikaya Gupta (email:kats : 1
                                   jvarga : 1
                               [:philipp] : 1
                                    miles : 1
                                 overholt : 1
                Andrew McCreight [:mccr8] : 1
    
      Commenters: 25
    
                                   willkg : 309
                                jwhitlock : 18
                                   Lonnen : 8
                                   jvarga : 8
                                     kats : 7
                                      ted : 5
                                madperson : 5
                                 overholt : 5
                                   sledru : 4
                                   Osmose : 4
                        mozilla+bugcloser : 4
                                     mats : 3
                      mozillamarcia.knous : 3
                             continuation : 3
                                jcoppeard : 3
                                 timeless : 2
                                  gsvelto : 2
                         kjacobs.bugzilla : 2
                                 achronop : 2
                                  sarentz : 2
                             tvandermerwe : 1
                                    miles : 1
                                     drno : 1
                             bogdan.maris : 1
                                   sdetar : 1
    
      Tracker bugs: 2
    
          1518281: [tracker] switch from rabbitmq to pub/sub
    
      Statistics
    
          Youngest bug : 0.0d: 1540831: antenna deploy: 29 (pub/sub)
       Average bug age : 101.5d
        Median bug age : 5.0d
            Oldest bug : 3383.0d: 539370: Missing symbols for GTK system libraries, libgt...
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 51
    
        * 4918: bug 1547411: remove crontabber app (willkg)
        * 4916: bug 1547807: cronrun fixes (willkg)
        * 4915: bug 1542388: archivescraper fixes (willkg)
        * 4914: bug 1542388: rewrite archivescraper as Django command (willkg)
        * 4913: bug 1542395: implement verifyprocessed Django cmd (willkg)
        * 4911: bug 1546978: Update permissions, refresh LogEntry admin view (jwhitlock)
        * 4912: bug 1543097: Rename raven_client to sentry_client (jwhitlock)
        * 4910: bug 1542392: fix depcheck to tell us if it's using a safety api key (willkg)
        * 4909: bug 1546640: upgrade jquery to 3.4.0 (willkg)
        * 4906: bug 1540704: Update to Django 2.2 (jwhitlock)
        * 4908: bug 1542391: rewrite elasticsearch-cleanup crontabber job (willkg)
        * 4907: bug 1546433: refactor Elasticsearch index delete code (willkg)
        * 4904: bug 1546433: refactor Elasticsearch index creation code (willkg)
        * 4905: bug 1545784: deal with "504 Deadline Exceeded" (willkg)
        * 4903: bug 1546254: add django cmd support to socorro-cmd (willkg)
        * 4902: bug 1544919: Add FallbackToPipeAction (jwhitlock)
        * 4901: bug 1544919: fix scripts/process_crashes.sh to take from stdin (willkg)
        * 4900: bug 1544919: More doc tweaks - README paths, process_app command (jwhitlock)
        * 4898: bug 1544919: Remove incorrect "no ids" message (jwhitlock)
        * 4899: bug 1544919: Add note for API token permissions for crash data (jwhitlock)
        * 4896: bug 1544919: Refresh webapp service docs (jwhitlock)
        * 4897: bug 1544497: fix comments tab in signature report (willkg)
        * 4894: bug 1544919: Update processor docs and pubsub publish command (jwhitlock)
        * 4895: fix bug 1544872: Update fixture for oidcprovider 0.7.0 (jwhitlock)
        * 4893: bug 1544543: Add uuid to allowed keys for RawCrash (jwhitlock)
        * 4892: bug 1514294: Remove webpack from webapp docs (jwhitlock)
        * 4891: Bug 1544449 - Fix NoteXPCOMChild class name. (amccreight)
        * 4890: Update docs (willkg)
        * 4889: bug 1542392: rewrite monitoring crontabber app as Django command (willkg)
        * 4887: bug 1542394: rewrite updatesignatures as Django command (willkg)
        * 4888: bug 1543465: add bug_type=defect parameter to report bug url (philipp-sumo)
        * 4886: Move markus configuration to settings (willkg)
        * 4885: bug 1543176: fix sentry-cli (willkg)
        * 4884: bug 1542865: fix cronrun to send errors to sentry (willkg)
        * 4883: bug 1542390: rewrite bugzilla associations crontabber job (willkg)
        * 4882: bug 1538243: update js-yaml (willkg)
        * 4880: bug 1513346: remove python 2 bits from signature generation (willkg)
        * 4881: bug 1541090: add __clear_cache to prefix list (willkg)
        * 4879: Update dependencies (willkg)
        * 4876: fix bug 1541474: add real_drop_in_place to prefix list (staktrace)
        * 4878: bug 1541890: fix local dev setup issues (willkg)
        * 4877: bug 1540871: remove rabbitmq (willkg)
        * 4875: bug 1480214: run auditgroups weekly (willkg)
        * 4874: bug 1493687: fix tests that fail at 8:00pm EDT (willkg)
        * 4873: bug 1493687: add the tests (willkg)
        * 4872: bug 1540680: nix MissingProcessedCrashes (willkg)
        * 4866: bug 1493687: rewrite crontabber as a django command (willkg)
        * 4871: bug 1539130: redo admin for PolicyException (willkg)
        * 4870: bug 1540705: fix CoC text and add links (willkg)
        * 4865: bug 1539130: add PolicyException to auditgroups machinery (willkg)
        * 4869: bug 1540858: fix /api/Reprocessing timeouts (willkg)
    
        Committers:
                   willkg :    36  ( +3731,  -6117,  157 files)
                jwhitlock :    12  (  +472,   -337,   33 files)
               amccreight :     1  (    +1,     -1,    1 files)
             philipp-sumo :     1  (    +2,     -0,    2 files)
                staktrace :     1  (    +1,     -0,    1 files)
    
                    Total :        ( +4207,  -6455,  177 files)
    
        Most changed files:
          socorro/cron/crontabber_app.py (9)
          webapp-django/crashstats/cron/__init__.py (9)
          webapp-django/crashstats/settings/base.py (8)
          webapp-django/crashstats/cron/management/commands/cronrun.py (7)
          socorro/unittest/cron/test_crontabber_app.py (6)
          docker/config/local_dev.env (4)
          docker/run_setup.sh (4)
          docs/localdevenvironment.rst (4)
          socorro-cmd (4)
          docker/run_update_data.sh (4)
    
        Age stats:
              Youngest PR : 0.0d: 4918: bug 1547411: remove crontabber app
           Average PR age : 0.2d
            Median PR age : 0.0d
                Oldest PR : 5.0d: 4866: bug 1493687: rewrite crontabber as a django com...
    
      mozilla-services/antenna:
    
        Merged PRs: 4
    
        * 315: bug 1547804: process all ProcessType=gpu crash reports (willkg)
        * 314: Update probably-low-risk dependencies (willkg)
        * 313: bug 1540705: add CoC .md text and links (willkg)
        * 312: Fix circle ci image (willkg)
    
        Committers:
                   willkg :     4  (  +173,   -125,   11 files)
    
                    Total :        (  +173,   -125,   11 files)
    
        Most changed files:
          antenna/throttler.py (1)
          tests/unittest/test_throttler.py (1)
          antenna/ext/pubsub/crashpublish.py (1)
          requirements/constraints.txt (1)
          requirements/default.txt (1)
          CODE_OF_CONDUCT.md (1)
          CODE_OF_CONDUCT.rst (1)
          CONTRIBUTING.rst (1)
          README.rst (1)
          docs/index.rst (1)
    
        Age stats:
              Youngest PR : 0.0d: 315: bug 1547804: process all ProcessType=gpu crash ...
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 315: bug 1547804: process all ProcessType=gpu crash ...
    
      mozilla-services/tecken:
    
        Merged PRs: 3
    
        * 1740: Remove duplicate CoC file, update links in README (willkg)
        * 1733: Update dependency Sphinx to v2.0.1 (renovate[bot])
        * 1717: Update django to 2.1.8 (pyup-bot)
    
        Committers:
                   willkg :     1  (    +5,    -26,    2 files)
            renovate[bot] :     1  (    +1,     -1,    1 files)
                 pyup-bot :     1  (    +3,     -3,    1 files)
    
                    Total :        (    +9,    -30,    4 files)
    
        Most changed files:
          README.md (1)
          code_of_conduct.md (1)
          docs-requirements.txt (1)
          requirements.txt (1)
    
        Age stats:
              Youngest PR : 0.0d: 1740: Remove duplicate CoC file, update links in README
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 1740: Remove duplicate CoC file, update links in README
    
      mozilla-services/buildhub2:

        Closed issues: 5
    
        * 521: CODE_OF_CONDUCT.md file missing 
        * 533: onboarding-related issues (willkg)
        * 498: Wiki changes (willkg)
        * 530: move to mozilla/services (willkg, autrilla)
        * 90: Help missioncontrol migrate 
    
        Merged PRs: 4
    
        * 538: Apply Dockerflow middleware before security middleware (autrilla)
        * 534: update docs and Dockerfile (willkg)
        * 531: Switch "mozilla" to "mozilla-services"; update docs (#530) (willkg)
        * 522: Add Mozilla Code of Conduct (Mozilla-GitHub-Standards)
    
        Committers:
                   willkg :     2  (  +123,   -210,    9 files)
                 autrilla :     1  (    +1,     -1,    1 files)
          Mozilla-GitHub- :     1  (   +15,     -0,    1 files)
    
                    Total :        (  +139,   -211,   10 files)
    
        Most changed files:
          buildhub/settings.py (3)
          Dockerfile (1)
          Makefile (1)
          docs/Dockerfile (1)
          docs/dev.rst (1)
          ui/src/App.js (1)
          README.md (1)
          contribute.json (1)
          docs/deployment.rst (1)
          CODE_OF_CONDUCT.md (1)
    
        Age stats:
              Youngest PR : 0.0d: 538: Apply Dockerflow middleware before security mid...
           Average PR age : 0.5d
            Median PR age : 0.0d
                Oldest PR : 2.0d: 522: Add Mozilla Code of Conduct
    
    
    All repositories
    ================
    
      Total closed issues/bugs: 71
      Total merged PRs: 62
    
    
    Contributors
    ============
    
      [:philipp]
      Adrian
      Alex Chronopoulos [:achronop]
      Andrew McCreight [:mccr8]
      Andrew Overholt [:overholt]
      Bogdan Maris [:bogdan_maris], Release Desktop QA
      continuation
      Dana Keeler (she/her) (use needinfo) (:keeler for reviews)
      drno
      gsvelto
      Jan Varga [:janv]
      Jeff Muizelaar [:jrmuizel]
      John Whitlock [:jwhitlock]
      Jon Coppeard (:jonco)
      Kartikaya Gupta
      Kevin Jacobs [:kjacobs]
      Liz Henry (:lizzard) (use needinfo)
      Lonnen
      madperson
      Marcia Knous [:marcia - needinfo? me]
      mats
      Mike Hommey [:glandium]
      miles
      Nico Grunbaum [:ng]
      Osmose
      overholt
      sdetar
      sledru
      staktrace
      Stefan Arentz [:st3fan]
      ted
      timeless
      tvandermerwe
      Will Kahn-Greene [:willkg] ET needinfo? me
