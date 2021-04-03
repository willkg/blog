.. title: Socorro: February 2019 happenings
.. slug: socorro_2019_02
.. date: 2019-03-11 09:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

This blog post summarizes Socorro activities in February.


.. TEASER_END

Staff in February
=================

Me.


Highlights of February
======================

* Fixed UI/UX issues:

  * Show friendly build date. (:bz:`606630`)
  * Don't show correlations tab for unsupported products. (:bz:`1315109`)
  * Add "startup_crash" to defaults in signature reports tab. (:bz:`1422007`)
  * Fix crash signature in bug summary. (:bz:`1377632`)
  * Redid From/To date input fields on Crash Stats site. No more timezone
    shenanigans. (:bz:`1438001`, :bz:`1328256`)

* Fixed some low-risk security-related issues:

  * Stop using ``shell=True``. (:bz:`1389186`)
  * Escape site-wide status messages. (:bz:`1401274`)

* Infrastructure-related changes:

  * Switched crontabber, processor, and webapp to mozlog format. (:bz:`1467578`)
  * Implement ``/__heartbeat__`` and ``/__lbheartbeat__`` Dockerflow endpoints.
    (:bz:`1419899`)

* Code cleanup

  * Redo BetaVersionRule to use VersionString API in webapp (now the processor
    doesn't touch the db again). (:bz:`1510658`)
  * Move de-nulling from collector to processor. (:bz:`1357246`)
  * Fixed inconsistent usage of configuration, removed more dead code, some
    Python 3 and style fixes

* Upgraded dependencies


Bugzilla and GitHub stats for February
======================================

::

    Period (2019-02-01 -> 2019-02-28)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 29
      Creators: 6
    
           Will Kahn-Greene [:willkg] ET  : 24
                        Gene Wood [:gene] : 1
                     Liz Henry (:lizzard) : 1
                      Wayne Mery (:wsmwk) : 1
               Nicholas Nethercote [:njn] : 1
                   Pascal Chevrel:pascalc : 1
    
      Bugs resolved: 59
    
                                    FIXED : 44
                               INCOMPLETE : 1
                               WORKSFORME : 3
                                DUPLICATE : 1
                                  WONTFIX : 10
    
      Resolvers: 8
    
           Will Kahn-Greene [:willkg] ET  : 52
                                   bpitts : 2
                                      ted : 1
                                 vseerror : 1
                   Miles Crabill [:miles] : 1
                                 cdenizet : 1
                           cristian.fogel : 1
    
      Commenters: 33
    
                                   willkg : 226
                                  peterbe : 21
                                 vseerror : 7
                                  gsvelto : 7
                              is2ei.horie : 6
                                    kairo : 5
                                   adrian : 5
                                   bpitts : 5
                                 cdenizet : 5
                      mozillamarcia.knous : 5
                                jclaudius : 5
                                   mkelly : 4
                        mozilla+bugcloser : 4
                                      ted : 3
                                   dbaron : 3
                                  rhelmer : 3
                             chris.lonnen : 3
                           adrian.aichner : 3
                            mcastelluccio : 3
                                     gene : 3
                           cristian.fogel : 2
                                   lhenry : 2
                                dmandelin : 1
                                    laura : 1
                                 benjamin : 1
                                    miles : 1
                           Tobias.Besemer : 1
                            cooldipanks14 : 1
                               xidorn+moz : 1
                                 culucenk : 1
                                s.kaspari : 1
                             n.nethercote : 1
                                  pascalc : 1
    
      Tracker bugs: 0
    
      Statistics
    
          Youngest bug : 0.0d: 1525004: socorro deploy: 362
       Average bug age : 401.2d
        Median bug age : 199.0d
            Oldest bug : 3024.0d: 606630: Human readable build dates
    
    GitHub
    ======
    
      mozilla-services/antenna: 5 prs
    
        Merged PRs:
    
        * 294: Fix pydocstyle lint issues (willkg)
        * 293: fix bug 1529026: make verification a separate step (willkg)
        * 292: fix bug 1527919: use console logging in a local dev environment (willkg)
        * 291: fix bug 1357246: remove de-nulling code (willkg)
        * 290: fix bug 1527348: add metrics for de_null (willkg)
    
        Committers:
                   willkg :     5  (  +270,   -203,   20 files)
    
                    Total :        (  +270,   -203,   20 files)
    
        Most changed files:
          antenna/app.py (3)
          antenna/breakpad_resource.py (3)
          antenna/ext/s3/connection.py (2)
          antenna/ext/s3/crashstorage.py (2)
          antenna/util.py (2)
          antenna/ext/crashstorage_base.py (1)
          antenna/ext/fs/crashstorage.py (1)
          antenna/gunicornhooks.py (1)
          antenna/health_resource.py (1)
          antenna/metrics.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 294: Fix pydocstyle lint issues
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 294: Fix pydocstyle lint issues
    
      mozilla-services/socorro: 37 prs
    
        Merged PRs:
    
        * 4835: bug 1529342: redo Elasticsearch-related configuration (willkg)
        * 4836: bug 1513346: import Queue from non-six place (willkg)
        * 4831: bug 1493436: Add MessageLoop::PostTask and MessageLoop::PostTask_Helper to skip list (jrmuizel)
        * 4834: fix bug 1530674: fix version sorting to ignore invalid versions (willkg)
        * 4833: bug 1529342 - remove change default, executor_identity, ThreadedTaskManagerWithConfigSetup (willkg)
        * 4832: bug 1529342: reduce crontabber some more (willkg)
        * 4830: bug 1527908: convert to Python 3 super format (willkg)
        * 4829: bug 1529342: remove sighup handling (willkg)
        * 4828: bug 1529342: redo logging in socorro apps (willkg)
        * 4827: fix bug 1528388: add breakpad binaries to socorro_app image (willkg)
        * 4791: Add gkrust_shared::oom_hook::hook to the prefix list. (jrmuizel)
        * 4826: bug 1527728: fix versions in nav bar (willkg)
        * 4825: fix bug 1393416: stop copying Winsock_LSP to processed crash (willkg)
        * 4824: bug 1419899: update monitoring page (willkg)
        * 4823: fix bug 1419899: implement __heartbeat__ and __lbheartbeat__ (willkg)
        * 4822: fix bug 1525614: use mozlog for gunicorn (willkg)
        * 4821: fix bug 1526918: upgrade to django 2.1.7 (willkg)
        * 4820: fix bug 1526918: upgrade django to 2.1.6 (willkg)
        * 4818: Add missing versions to "make updatedata" (willkg)
        * 4819: bug 1510658: track cache misses for BetaVersionRule (willkg)
        * 4817: fix bug 1510658: redo BetaVersionRule to use VersionString API in webapp (willkg)
        * 4816: bug 1525614: adjust server logging settings for webapp (willkg)
        * 4814: fix bug 1438001: drop flatpicker for HTML date/time fields (willkg)
        * 4815: fix bug 1146956: add UTC label to date processed field (willkg)
        * 4813: fix bug 1377632: fix crash signature bug summary (willkg)
        * 4812: fix bug 1467578: support mozlog for processor, crontabber, and webapp (willkg)
        * 4811: fix bug 1525098: add licence header to all python files (willkg)
        * 4810: fix bug 1525044: switch to 2-space indent for html files (willkg)
        * 4809: Update requirements (willkg)
        * 4808: fix bug 606630: show friendly build date (willkg)
        * 4807: fix bug 1315109: don't show correlations tab if not supported (willkg)
        * 4806: fix bug 1422007: add "startup_crash" to defaults in signature reports tab (willkg)
        * 4805: Adjust editorconfig with indent sizes (willkg)
        * 4804: fix bug 1401274: nix the user-provided value (willkg)
        * 4803: bug 1357246: add de-nulling to processor (willkg)
        * 4801:  fix bug 1483246: move base to crashstats (willkg)
        * 4800: fix bug 1389186: stop doing shell=True (willkg)
    
        Committers:
                   willkg :    35  ( +7138,  -6882,  432 files)
                 jrmuizel :     2  (    +3,     -0,    1 files)
    
                    Total :        ( +7141,  -6882,  433 files)
    
        Most changed files:
          socorro/processor/processor_2015.py (6)
          webapp-django/crashstats/crashstats/models.py (5)
          socorro/processor/breakpad_transform_rules.py (5)
          socorro/processor/mozilla_transform_rules.py (5)
          webapp-django/crashstats/settings/base.py (5)
          webapp-django/crashstats/crashstats/templatetags/jinja_helpers.py (5)
          socorro/external/es/crashstorage.py (4)
          socorro/external/rabbitmq/crashstorage.py (4)
          socorro/lib/threaded_task_manager.py (4)
          socorro/app/socorro_app.py (4)
    
        Age stats:
              Youngest PR : 0.0d: 4836: bug 1513346: import Queue from non-six place
           Average PR age : 0.6d
            Median PR age : 0.0d
                Oldest PR : 22.0d: 4791: Add gkrust_shared::oom_hook::hook to the prefix...
    
      mozilla-services/socorro-pigeon: 1 prs
    
        Merged PRs:
    
        * 42: Move circleci config to proper place (sciurus)
    
        Committers:
                  sciurus :     1  (    +0,     -0,    1 files)
    
                    Total :        (    +0,     -0,    1 files)
    
        Most changed files:
          .circleci/config.yml (1)
    
        Age stats:
              Youngest PR : 0.0d: 42: Move circleci config to proper place
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 42: Move circleci config to proper place
    
    
      All repositories:
    
        Total merged PRs: 43
    
    
    Contributors
    ============
    
      adrian
      adrian.aichner
      benjamin
      Brian Pitts
      cdenizet
      cooldipanks14
      cristian.fogel
      culucenk
      dbaron
      dmandelin
      Gene Wood [:gene]
      gsvelto
      is2ei.horie
      jclaudius
      jrmuizel
      kairo
      laura
      Liz Henry (:lizzard) (use needinfo)
      Lonnen
      mcastelluccio
      Miles Crabill [:miles] [also mcrabill
      Osmose
      mozillamarcia.knous
      n.nethercote
      Nicholas Nethercote [:njn]
      Pascal Chevrel:pascalc
      pascalc
      peterbe
      rhelmer
      s.kaspari
      Ted
      Tobias.Besemer
      vseerror
      Wayne Mery (:wsmwk)
      Will Kahn-Greene [:willkg] ET needinfo? me
      xidorn+moz
    
