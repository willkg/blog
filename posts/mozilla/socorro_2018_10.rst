.. title: Socorro: October 2018 happenings
.. slug: socorro_2018_10
.. date: 2018-11-02 9:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the Breakpad
crash reporter asks the user if the user would like to send a crash report. If
the user answers "yes!", then the Breakpad crash reporter collects data related
to the crash, generates a crash report, and submits that crash report as an HTTP
POST to Socorro. Socorro saves the crash report, processes it, and provides an
interface for aggregating, searching, and looking at crash reports.

October was a busy month! This blog post covers what happened.


.. TEASER_END

Staff in October
================

For the duration of October, I was on my own engineering-wise.

One person isn't a critical mass for a project, so I'm dealing with that
by doing self-reviews and discussing the finer points of things with
a stuffed owl. Socorro and crash ingestion is a huge project and it's
been tough. If you want to talk more about that, toss me an email, ping
me on IRC, or catch me at the All Hands in December.


Highlights of October
=====================

October was busy!

* Lots of work towards getting rid of alembic/sqlalchemy and moving all
  database management to Postgres. (:bz:`1361394`)

  * Move signature data to a Django-managed table, rewrite all
    signature-bookkeeping consumers and producers. (:bz:`1463121`)
  * Move bug association data to a Django-managed table, rewrite all
    bug association consumers and producers. (:bz:`1493768`)
  * Move platform data to a Django-managed table, rewrite platform
    consumers. (:bz:`1498441`)
  * Move crontabber data to Django-managed tables, rewrite crontabber
    consumers and producers. (:bz:`1493687`)
 
* Rewrite ``BetaVersionRule`` to use Buildhub for version lookups which fixed
  a bunch of long-standing issues. (:bz:`1501780`, :bz:`1486035`, :bz:`1295963`)

* Add a bunch of dataflow documentation.

* Split ``java_stack_trace`` into a sanitized and raw versions. (:bz:`1496599`)

* Split ``moz_crash_reason`` into a sanitized and raw versions. (:bz:`1502477`)

* Add webapp tests to our Python 3 test scaffolding. (:bz:`1406703`)

* During flights and while traveling, Lonnen worked on fixes to migrate us
  to Python 3.

* Bunch of signature generation fixes.

* Bunch of other bug fixes, PII access requests, and other things.

I'm one or two pull requests away from ditching alembic, sqlalchemy,
ftpscraper, a bunch of tables, and all our stored procedures. That's a huge
chunk of technical debt and covers a lot of bugs that we'll get to close out.

After finishing that, the next project is the Python 3 migration.

I also spent some time looking at `chkimg <https://github.com/heycam/chkimg/>`_
as part of annotating crashes when the code in memory doesn't match
the binary (:bz:`1274628`). That's pretty interesting work. I hope to
spend some time with a "cupcake" of this problem to get a better feel
for performance issues when operationalizing that utility.


Bugzilla and GitHub stats for October
=====================================

::

    Period (2018-10-01 -> 2018-10-31)
    =================================


    Bugzilla
    ========

      Bugs created: 53
      Creators: 17

           Will Kahn-Greene [:willkg] ET  : 34
                Andrew McCreight [:mccr8] : 2
                   Cristi Fogel [:cfogel] : 2
           Cameron McCormack (:heycam) (a : 1
                    Julien Vehent [:ulfr] : 1
           James Willcox (:snorp) (jwillc : 1
           Julien Cristau [:jcristau] (ba : 1
                              Brian Pitts : 1
                           kiavash.satvat : 1
           Marcia Knous [:marcia - needin : 1
                      Jan Henning [:JanH] : 1
           Kartikaya Gupta (email:kats@mo : 1
                Brian Hackett (:bhackett) : 1
               Calixte Denizet (:calixte) : 1
           Sebastian Kaspari (:sebastian) : 1
                  Yaron Tausky [:ytausky] : 1
                               [:philipp] : 1

      Bugs resolved: 54

                                  WONTFIX : 4
                               WORKSFORME : 3
                                    FIXED : 47

      Resolvers: 9

           Will Kahn-Greene [:willkg] ET  : 45
                              Brian Pitts : 3
                                    nchen : 1
           Miles Crabill [:miles] [also m : 1
                                cpeterson : 1
           Ted Mielczarek [:ted] [:ted.mi : 1
           Cameron McCormack (:heycam) (a : 1
                                  peterbe : 1

      Commenters: 41

        Top 10:

                                   willkg : 179
                        mozilla+bugcloser : 39
                                  peterbe : 26
                                   bpitts : 25
                                  nthomas : 8
                             continuation : 8
                                      ted : 7
                                cpeterson : 6
                                 cdenizet : 4
                                     lars : 3

      Statistics

          Youngest bug : 0.0d: 1495416: upgrade to django 1.11.16
       Average bug age : 194.3d
        Median bug age : 3.0d
            Oldest bug : 3028.0d: 578760: Allow (manual) annotation of system graphs with...

    GitHub
    ======

      mozilla-services/antenna: 2 prs

        Committers:
                   willkg :     2  (   +50,     -7,    3 files)

                    Total :        (   +50,     -7,    3 files)

        Most changed files:
          antenna/throttler.py (2)
          antenna/breakpad_resource.py (1)
          tests/unittest/test_throttler.py (1)

        Age stats:
              Youngest PR : 0.0d: 279: bug 1501298: add ReferenceBrowser to supported ...
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 279: bug 1501298: add ReferenceBrowser to supported ...

      mozilla-services/socorro: 53 prs

        Committers:
                   willkg :    50  ( +3545,  -3535,  123 files)
                   lonnen :     2  (   +44,  -1054,   14 files)
                   heycam :     1  (    +1,     -0,    1 files)

                    Total :        ( +3590,  -4589,  133 files)

        Most changed files:
          webapp-django/crashstats/crashstats/models.py (15)
          socorro/processor/mozilla_transform_rules.py (8)
          socorro/unittest/processor/test_mozilla_transform_rules.py (8)
          webapp-django/crashstats/crashstats/utils.py (7)
          webapp-django/crashstats/api/tests/test_views.py (7)
          webapp-django/crashstats/crashstats/tests/test_models.py (7)
          webapp-django/crashstats/crashstats/jinja2/crashstats/report_index.html (4)
          webapp-django/crashstats/supersearch/views.py (4)
          webapp-django/crashstats/topcrashers/views.py (4)
          webapp-django/crashstats/crashstats/tests/test_views.py (4)

        Age stats:
              Youngest PR : 0.0d: 4681: bug 1503591: tweak create_recent_indices to hav...
           Average PR age : 0.7d
            Median PR age : 0.0d
                Oldest PR : 15.0d: 4597: WIP: incremental progress towards bug 1469718

      mozilla-services/socorro-pigeon: 0 prs

      All repositories:

        Total merged PRs: 55
