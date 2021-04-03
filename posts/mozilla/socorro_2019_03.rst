.. title: Socorro: March 2019 happenings
.. slug: socorro_2019_03
.. date: 2019-04-01 12:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

This blog post summarizes Socorro activities in March.


.. TEASER_END

Staff in March
==============

Me.


Highlights of March
===================

* Pub/Sub migration

  * Changed the collector, processor, and webapp to use Google Cloud Platform
    Pub/Sub instead of RabbitMQ for queuing for crash processing (:bz:`1527343`,
    :bz:`1527346`, :bz:`1527345`)

    This is on stage, but will go to prod very soon.

* Development and infrastructure-related changes

  * Redo tests and configuration in Antenna to match Socorro (:bz:`1531865`)
  * Update Docker image in CI. (:bz:`1540248`)
  * Update base Docker image for all containers. (:bz:`1539272`)
  * Rewrite archivescraper to use multi-processing which makes it SOOOOO much
    faster. (:bz:`1536147`)

* Upgraded dependencies


Bugzilla and GitHub stats for March
===================================
    
::

    Period (2019-03-01 -> 2019-03-31)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 32
      Creators: 9
    
           Will Kahn-Greene [:willkg] ET  : 20
           Marcia Knous [:marcia - needin : 1
               Calixte Denizet (:calixte) : 1
              Andrew Overholt [:overholt] : 1
                    Edouard Oger [:eoger] : 1
           Robert Strong (Robert they/the : 1
           Adam Gashlin (he/him) [:agashl : 1
             Myk Melez [:myk] [@mykmelez] : 1
           Kartikaya Gupta (email:kats@mo : 1
    
      Bugs resolved: 22
    
                                    FIXED : 17
                                  WONTFIX : 3
                               WORKSFORME : 1
                                  INVALID : 1
    
      Resolvers: 9
    
           Will Kahn-Greene [:willkg] ET  : 15
              Marco Castelluccio [:marco] : 1
                Andrew McCreight [:mccr8] : 1
                                    miles : 1
               Peter Bengtsson [:peterbe] : 1
                              Brian Pitts : 1
                                   nfroyd : 1
                            mcastelluccio : 1
    
      Commenters: 25
    
                                   willkg : 84
                                  peterbe : 6
                                    eoger : 6
                             continuation : 5
                                   gguthe : 4
                            mcastelluccio : 4
                                      amk : 4
                                      ted : 3
                                   nfroyd : 3
                                   sledru : 3
                                      myk : 3
                       robert.strong.bugs : 2
                                 jmathies : 2
                               viveknegi1 : 2
                                 nehagarw : 2
                                     kats : 2
                        mozilla+bugcloser : 1
                                   mkelly : 1
                      mozillamarcia.knous : 1
                                    miles : 1
                               nalexander : 1
                                  gsvelto : 1
                                cpeterson : 1
                                 agashlin : 1
                                  jwalker : 1
    
      Tracker bugs: 0
    
    
      Statistics
    
          Youngest bug : 0.0d: 1533007: antenna deploy: 28
       Average bug age : 45.1d
        Median bug age : 3.0d
            Oldest bug : 551.0d: 1400076: running antenna with socorro
    
    GitHub
    ======
    
      mozilla-services/antenna: 16 prs
    
        Merged PRs:
    
        * 310: bug 1538202: fix the docker CMD line to use the new worker (willkg)
        * 309: Add code of conduct (willkg)
        * 308: bug 1538202: fix SystemExit (attempt 3) (willkg)
        * 307: bug 1538202: add monkey.patch_all() calls to guarantee patching (willkg)
        * 306: bug 1538202: remove preload (willkg)
        * 305: Add mozilla/socorro_collector:latest image (willkg)
        * 304: bug 1527343: switch to use CRASHPUBLISH_SERVICE_ACCOUNT_FILE (willkg)
        * 303: Update docs regarding RabbitMQ -> Pub/Sub (willkg)
        * 301: fix bug 1533732: add support for JSON-encoded fields (willkg)
        * 302: bug 1533732: fix miniposter to support JSON blobs (willkg)
        * 299: fix bug 1527343: implement publishing to Pub/Sub (willkg)
        * 300: fix bug 1359147: fix s3 and pubsub startup and health checks (willkg)
        * 298: Update dependencies (willkg)
        * 297: bug 1531865: fix image name in build/push step (willkg)
        * 296: bug 1517807: Fix s3 test class name; remove pytest-env (willkg)
        * 295: fix bug 1531865: redo tests and configuration (willkg)
    
        Committers:
                   willkg :    16  ( +1662,   -752,   46 files)
    
                    Total :        ( +1662,   -752,   46 files)
    
        Most changed files:
          antenna/ext/pubsub/crashpublish.py (5)
          docker/Dockerfile (4)
          requirements/default.txt (4)
          requirements/constraints.txt (3)
          testlib/mini_poster.py (3)
          tests/systemtest/conftest.py (3)
          tests/unittest/conftest.py (3)
          .circleci/config.yml (3)
          docker/config/local_dev.env (3)
          docker/run_tests.sh (3)
    
        Age stats:
              Youngest PR : 0.0d: 310: bug 1538202: fix the docker CMD line to use the...
           Average PR age : 0.1d
            Median PR age : 0.0d
                Oldest PR : 1.0d: 299: fix bug 1527343: implement publishing to Pub/Sub
    
      mozilla-services/socorro: 27 prs
    
        Merged PRs:
    
        * 4867: bug 1540248: fix setting up docker-compose in CI (willkg)
        * 4862: bug 1539233: fix table and add missing processed crash check to verifyprocessed (willkg)
        * 4863: bug 1539272: switch to 3.6.8-slim-stretch (willkg)
        * 4861: Add code of coduct file (willkg)
        * 4860: bug 1527345: reduce Pub/Sub pulling (willkg)
        * 4859: bug 1536903: fix queryset for processing in admin (willkg)
        * 4858: bug 1527345: fix PubSubCrashQueue iterator (willkg)
        * 4857: bug 1536903: improve bulk processing performance (willkg)
        * 4856: Switch to readthedocs config file (willkg)
        * 4855: bug 1527346: use credentials file when creating PublisherClient (willkg)
        * 4854: Minor fixes (willkg)
        * 4853: bug 1527345: fix handling of "test" crash ids (willkg)
        * 4852: bug 1400076: rework collector service to work right (willkg)
        * 4850: bug 1536903: add bulk process for missing processed crashes (willkg)
        * 4851: bug 1527346: configure service_account_file for webapp (willkg)
        * 4848: fix bug 1527346: switch webapp to use Pub/Sub (willkg)
        * 4849: bug 1536147: make archivescraper faster (willkg)
        * 4847: bug 1527345: implement Pub/Sub queue and scaffolding (willkg)
        * 4846: Change Buildhub base URL (peterbe)
        * 4845: bug 1527345: redo FetchTransformSaveApp and queuing (willkg)
        * 4842: Update Python dependencies (willkg)
        * 4844: bug 1534617: add "is_processed" check (willkg)
        * 4843: bug 1534617: add "report url link" to Django admin page (willkg)
        * 4841: fix bug 1534402: fix error handling in multiprocessing code (willkg)
        * 4840: fix bug 1528243: verify crashes are processed (willkg)
        * 4839: Fix db setup (willkg)
        * 4838: fix typos in fetch_crashids documentation (froydnj)
    
        Committers:
                   willkg :    25  ( +2899,  -1591,   71 files)
                  peterbe :     1  (    +1,     -1,    1 files)
                  froydnj :     1  (    +2,     -2,    1 files)
    
                    Total :        ( +2902,  -1594,   72 files)
    
        Most changed files:
          webapp-django/crashstats/crashstats/admin.py (7)
          socorro/external/pubsub/crashqueue.py (7)
          webapp-django/crashstats/crashstats/models.py (5)
          socorro/cron/jobs/verify_processed.py (4)
          socorro/unittest/cron/jobs/test_verify_processed.py (3)
          docker/config/local_dev.env (3)
          webapp-django/crashstats/settings/base.py (3)
          socorro/unittest/conftest.py (2)
          docker/run_tests.sh (2)
          docker/run_tests_in_docker.sh (2)
    
        Age stats:
              Youngest PR : 0.0d: 4867: bug 1540248: fix setting up docker-compose in CI
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 1.0d: 4848: fix bug 1527346: switch webapp to use Pub/Sub
    
      mozilla-services/socorro-pigeon: 1 prs
    
        Merged PRs:
    
        * 43: Add code of conduct (willkg)
    
        Committers:
                   willkg :     1  (   +17,     -0,    1 files)
    
                    Total :        (   +17,     -0,    1 files)
    
        Most changed files:
          CODE_OF_CONDUCT.rst (1)
    
        Age stats:
              Youngest PR : 0.0d: 43: Add code of conduct
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 43: Add code of conduct
    
    
      All repositories:
    
        Total merged PRs: 44
    
    
    Contributors
    ============
    
      Adam Gashlin (he/him) [:agashlin]
      amk
      Andrew McCreight [:mccr8]
      Andrew Overholt [:overholt]
      Brian Pitts
      Calixte Denizet (:calixte)
      continuation
      cpeterson
      Edouard Oger [:eoger]
      eoger
      froydnj
      gguthe
      gsvelto
      jmathies
      jwalker
      Kartikaya Gupta (email:kats@mozilla.com)
      Marcia Knous [:marcia - needinfo? me]
      Marco Castelluccio [:marco]
      miles
      mkelly
      Myk Melez [:myk] [@mykmelez]
      nalexander
      nehagarw
      nfroyd
      Peter Bengtsson [:peterbe]
      Robert Strong (Robert they/them) [:rstrong] (use needinfo to contact me)
      sledru
      ted
      viveknegi1
      Will Kahn-Greene [:willkg] ET needinfo? me
