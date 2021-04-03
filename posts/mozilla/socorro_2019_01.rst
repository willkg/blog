.. title: Socorro: January 2019 happenings
.. slug: socorro_2019_01
.. date: 2019-02-13 10:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

January was a good month. This blog post summarizes activities.


.. TEASER_END

Staff in January
================

Me.


Highlights of January
=====================

I finished up some huge projects in December. Instead of starting the next one,
I spent some time focusing on UI/UX issues and low-priority bugs that had been
sitting around for a while:

* Upgraded dependencies and upgraded Django from 1.11 to 2.1. (:bz:`1512315`)

* Fixed UI/UX issues:

  * Improved the "Crash Not Found" page to discuss why the crash report might
    not be found and what to do about it. (:bz:`1299460`)

  * Redid the navbar on the Crash Stats site moving important links from the
    footer to the header. Thank you, Osmose! (:bz:`1511032`)

  * Added help text for all API endpoints. (:bz:`1158386`)

  * Added ``_facets`` to the Public API URL on the Super Search page. (:bz:`1239020`)

  * Added frame trust information to the report view. (:bz:`929095`)

  * Highlight line when viewing source code. Thank you, Osmose! (:bz:`1490622`)

* Cleaned up processing and searching of cpu_info, cpu_arch/cpu_name, and
  cpu_count fields. (:bz:`1519802`)

* Redid how we upgrade the Breakpad client. We no longer use a pre-built binary
  built using Taskcluster. (:bz:`1519475`, :bz:`1520570`)

* GitHub removed integrations, so we no longer have IRC notifications for GitHub
  activity and we no longer have the autocloser. I decided not to worry about
  IRC notifications--I don't think anyone paid attention to them other than me.
  I improved `rob-bugson
  <https://addons.mozilla.org/en-US/firefox/addon/rob-bugson/>`_ and added links
  to add a Bugzilla comment summarizing the merge. That's working out nicely
  and works better than the autocloser with confidential and security bugs.

* Fixed a lot of little issues when handling edge cases in the webapp and
  processor.


Bugzilla and GitHub stats for January
=====================================

::

    Period (2019-01-01 -> 2019-01-31)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 36
      Creators: 13
    
               Will Kahn-Greene [:willkg] : 13
           Marcia Knous [:marcia - needin : 3
           Michael Kelly [:mkelly,:Osmose : 2
               Daniel Holbert [:dholbert] : 1
                       Eric Rahm [:erahm] : 1
               Gabriele Svelto [:gsvelto] : 1
                   David Bolter [:davidb] : 1
                Ted Campbell [:tcampbell] : 1
                    David Major [:dmajor] : 1
              Christian Holler (:decoder) : 1
           Sebastian Kaspari (:sebastian; : 1
                 Sebastian Hengst [:aryx] : 1
                    Aaron Klotz [:aklotz] : 1
    
      Bugs resolved: 52
    
                                  WONTFIX : 8
                               WORKSFORME : 2
                                    FIXED : 35
                               INCOMPLETE : 3
                                DUPLICATE : 3
                                  INVALID : 1
    
      Resolvers: 9
    
               Will Kahn-Greene [:willkg] : 38
           Michael Kelly [:mkelly,:Osmose : 5
               Peter Bengtsson [:peterbe] : 3
                   Miles Crabill [:miles] : 3
                              Brian Pitts : 1
              Marco Castelluccio [:marco] : 1
                Andrew McCreight [:mccr8] : 1
    
      Commenters: 38
    
                                   willkg : 114
                                  peterbe : 30
                        mozilla+bugcloser : 23
                                   mkelly : 19
                               viveknegi1 : 13
                                    kairo : 7
                                      ted : 7
                                   adrian : 6
                            mcastelluccio : 6
                                    miles : 4
                                cpeterson : 4
                               shes050117 : 4
                                   dmajor : 3
                      mozillamarcia.knous : 3
                           kiavash.satvat : 3
                                   gtatum : 3
                                 dholbert : 3
                         nhirata.bugzilla : 2
                             chris.lonnen : 2
                                     bugs : 2
                                   bpitts : 2
                                   lhenry : 2
                       spohl.mozilla.bugs : 2
                             continuation : 2
                               jmuizelaar : 2
                             aryx.bugmail : 2
                                     loon : 1
                                 vseerror : 1
                                     lars : 1
                                   dmaher : 1
                       alexandr.kovalenko : 1
                                 pulsebot : 1
                                    dluca : 1
                                 jmathies : 1
                                 overholt : 1
                            kohei.yoshino : 1
                                    erahm : 1
                                  dbolter : 1
    
      Tracker bugs: 1
    
          1091670: [tracker] Create a work flow for the creation and
            deployment of Support Classifiers
    
      Statistics
    
          Youngest bug : 0.0d: 1517290: socorro: deploy 358
       Average bug age : 432.9d
        Median bug age : 48.0d
            Oldest bug : 1701.0d: 1014607: comments tab is (0) but there are (3) crash rep...
    
    GitHub
    ======
    
      mozilla-services/antenna: 3 prs
    
        Committers:
                   willkg :     3  (  +236,   -199,    6 files)
    
                    Total :        (  +236,   -199,    6 files)
    
        Most changed files:
          antenna/throttler.py (1)
          Makefile (1)
          requirements/constraints.txt (1)
          requirements/default.txt (1)
          setup.cfg (1)
          tests/systemtest/test_content_length.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 289: bug 1523284: add Fenix to supported products
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 289: bug 1523284: add Fenix to supported products
    
      mozilla-services/socorro: 41 prs
    
        Committers:
                   willkg :    32  (  +560,   -881,   64 files)
                   Osmose :     7  (  +315,   -250,   26 files)
                 jrmuizel :     1  (    +1,     -0,    1 files)
                 pyup-bot :     1  (  +312,   -328,   33 files)
    
                    Total :        ( +1188,  -1459,  100 files)
    
        Most changed files:
          webapp-django/crashstats/crashstats/tests/test_views.py (5)
          socorro/external/es/super_search_fields.py (4)
          webapp-django/crashstats/settings/base.py (4)
          webapp-django/crashstats/crashstats/models.py (4)
          webapp-django/crashstats/crashstats/jinja2/crashstats/report_index.html (3)
          scripts/build-breakpad.sh (3)
          webapp-django/crashstats/base/jinja2/crashstats_base.html (3)
          webapp-django/crashstats/crashstats/templatetags/jinja_helpers.py (3)
          webapp-django/crashstats/api/views.py (3)
          webapp-django/crashstats/base/templatetags/jinja_helpers.py (3)
    
        Age stats:
              Youngest PR : 0.0d: 4799: fix bug 1508215: make graphics adapter/device k...
           Average PR age : 0.1d
            Median PR age : 0.0d
                Oldest PR : 2.0d: 4757: Scheduled monthly dependency update for January
    
      mozilla-services/socorro-pigeon: 0 prs
    
    
    
      All repositories:
    
        Total merged PRs: 44
    
    
    Contributors
    ============
    
      Aaron Klotz [:aklotz]
      adrian
      alexandr.kovalenko
      Andrew McCreight [:mccr8]
      aryx.bugmail
      Brian Pitts
      Christian Holler (:decoder)
      continuation
      cpeterson
      Daniel Holbert [:dholbert]
      David Bolter [:davidb]
      David Major [:dmajor]
      dluca
      dmaher
      Eric Rahm [:erahm]
      Gabriele Svelto [:gsvelto]
      gtatum
      jmathies
      jmuizelaar
      jrmuizel
      kairo
      kiavash.satvat
      kohei.yoshino
      lars
      lhenry
      Lonnen
      loon
      Marcia Knous [:marcia - needinfo? me]
      Marco Castelluccio [:marco]
      Michael Kelly [:mkelly,:Osmose]
      Miles Crabill [:miles]
      nhirata.bugzilla
      overholt
      Peter Bengtsson [:peterbe]
      Sebastian Hengst [:aryx]
      Sebastian Kaspari (:sebastian; :pocmo)
      shes050117
      spohl.mozilla.bugs
      ted
      Ted Campbell [:tcampbell]
      viveknegi1
      vseerror
      Will Kahn-Greene [:willkg]
