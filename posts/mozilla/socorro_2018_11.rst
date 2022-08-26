.. title: Socorro: November 2018 happenings
.. slug: socorro_2018_11
.. date: 2018-12-01 9:00
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

November was another busy month! This blog post covers what happened.


.. TEASER_END

Staff in November
=================

I was the sole engineer on Socorro for November.


Highlights of November
======================

November was very busy!

* Wrote a new scraper for archive.mozilla.org to pull just the information that
  Socorro needs for the ``BetaVersionRule`` to work correctly. Because we had a
  new scraper, I laid ftpscraper to rest. (:bz:`1506907`)

* Re-rewrote ``BetaVersionRule`` to run against the new
  ``crashstats_productversion`` table fed by the new archivescraper.
  (:bz:`1508335`)

* Rewrote various parts of the processor that handle exceptions to reduce layers
  of abstraction and simplify handling. (:bz:`1505233`, :bz:`1503434`)

* Removed one of the two DotDict implementations. Removed ujson so we're only
  using one json library. (:bz:`1506781`)

* Simplify crontabber and remove ``crontabber-state/`` page. (:bz:`1493687`)

* Got all the ``socorro/`` tests passing in Python 3. (:bz:`1406703`)

* Removed alembic, sqlalchemy, and everything managed by those. Now Socorro has
  one db migration system and one orm. This also removes the stored procedures
  that were being used to manage product/version data which had no tests and no
  documentation. (:bz:`1503383`, :bz:`1361394`)

* Signature generation fixes.

* Documentation updates and changes.

* Handled PII access requests.


Removing alembic, sqlalchemy, ftpscraper, a bunch of tables, and all our stored
procedures was a huge morass of technical debt. I've been working towards this
for a year. Before me, Peter and Adrian had worked on it for a long time, too.
The work was covered by a lot of bugs (:bz:`1361394`), Google docs,
spreadsheets, meetings, hopes, dreams, and many quarterly goals. It was a
monumental effort and now we can upgrade Postgres versions.

All the rewriting, reducing, and simplifying in November resulted in a codebase
that's *10,000 lines smaller*.

I'm probably half way through the Python 3 migration project. I've almost got
all the tests passing. After that, I'll start doing manual integration tests and
verification. If I don't hit any weird unknowns, I might finish this in
December.

After Python 3 migration, I'm going to work on upgrading Elasticsearch and
fixing SuperSearch related issues.


Bugzilla and GitHub stats for November
======================================

::

    Period (2018-11-01 -> 2018-11-30)
    =================================

    Bugzilla
    ========
    
      Bugs created: 51
      Creators: 12
    
               Will Kahn-Greene [:willkg] : 38
                   Marcia Knous [:marcia] : 3
                      Wayne Mery (:wsmwk) : 1
              Chris Peterson [:cpeterson] : 1
                Andrew McCreight [:mccr8] : 1
               Jeff Muizelaar [:jrmuizel] : 1
                                    Atoll : 1
                               [:philipp] : 1
                   Andreas Farre [:farre] : 1
               Gabriele Svelto [:gsvelto] : 1
           Michael Kelly [:mkelly,:Osmose : 1
           Petru-Mugurel Lingurar[:petru] : 1
    
      Bugs resolved: 63
    
                                    FIXED : 50
                               WORKSFORME : 5
                                  WONTFIX : 8
    
      Resolvers: 7
    
               Will Kahn-Greene [:willkg] : 58
               Andy Mikulski [:amikulski] : 1
                   Miles Crabill [:miles] : 1
                        mozilla+bugcloser : 1
                Andrew McCreight [:mccr8] : 1
               Jeff Muizelaar [:jrmuizel] : 1
    
      Commenters: 27
    
                                   willkg : 231
                        mozilla+bugcloser : 40
                                  peterbe : 11
                             continuation : 8
                                madperson : 8
                                   bpitts : 7
                                    miles : 5
                                      ted : 5
                                   adrian : 4
                      mozillamarcia.knous : 4
                                     kats : 3
                             chris.lonnen : 2
                                 vseerror : 2
                                cpeterson : 2
                               jmuizelaar : 2
                                   afarre : 2
                           petru.lingurar : 2
                                    kairo : 1
                                wlachance : 1
                                amikulski : 1
                                  cmiller : 1
                                  chutten : 1
                                   dthorn : 1
                                   emilio : 1
                                      rob : 1
                                  nkochar : 1
                                 sdaswani : 1
    
      Tracker bugs: 1
    
          1361394: [tracker] Simplify and clean up postgresql schema
    
      Statistics
    
          Youngest bug : 0.0d: 1503740: Thunderbird beta crashes showing up as nn.nb0
       Average bug age : 146.7d
        Median bug age : 2.0d
            Oldest bug : 1112.0d: 1221818: Do we need `special_product_platforms` table at...
    
    GitHub
    ======
    
      mozilla-services/antenna: 2 prs
    
        Committers:
                   willkg :     2  (    +4,     -4,    2 files)
    
                    Total :        (    +4,     -4,    2 files)
    
        Most changed files:
          requirements/default.txt (1)
          antenna/throttler.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 286: Update requests to 2.20.0
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 286: Update requests to 2.20.0
    
      mozilla-services/socorro: 52 prs
    
        Committers:
                   willkg :    49  ( +6443, -17082,  291 files)
                 jrmuizel :     1  (    +2,     -0,    1 files)
                   lonnen :     1  (    +7,   -178,    6 files)
               amccreight :     1  (    +1,     -0,    1 files)
    
                    Total :        ( +6453, -17260,  296 files)
    
        Most changed files:
          socorro/processor/mozilla_transform_rules.py (13)
          socorro/unittest/processor/test_mozilla_transform_rules.py (10)
          webapp-django/crashstats/manage/admin.py (7)
          docker/run_tests_python3.sh (7)
          socorro/cron/crontabber_app.py (6)
          socorro/processor/processor_2015.py (6)
          webapp-django/crashstats/crashstats/models.py (6)
          socorro/unittest/processor/test_breakpad_transform_rules.py (5)
          socorro/cron/jobs/archivescraper.py (5)
          socorro/processor/breakpad_transform_rules.py (5)
    
        Age stats:
              Youngest PR : 0.0d: 4734: bug 1504067: remove unittest from socorro/unitt...
           Average PR age : 0.2d
            Median PR age : 0.0d
                Oldest PR : 5.0d: 4703: fix bug 1505954: Add core::panicking::panic_bou...
    
      mozilla-services/socorro-pigeon: 0 prs
    
    
    
      All repositories:
    
        Total merged PRs: 54
    
    
    Contributors
    ============
    
      :Atoll
      [:philipp]
      adrian
      Andreas Farre [:farre]
      Andrew McCreight [:mccr8]
      Andy Mikulski [:amikulski]
      bpitts
      Chris Peterson [:cpeterson]
      chutten
      cmiller
      continuation
      dthorn
      emilio
      Gabriele Svelto [:gsvelto]
      Jeff Muizelaar [:jrmuizel]
      kairo
      kats
      lonnen
      madperson
      Marcia Knous [:marcia - needinfo? me]
      Michael Kelly [:mkelly,:Osmose]
      Miles Crabill [:miles] [also mcrabill
      nkochar
      peterbe
      Petru-Mugurel Lingurar[:petru]
      rob
      sdaswani
      ted
      vseerror
      Wayne Mery (:wsmwk)
      Will Kahn-Greene [:willkg] ET needinfo? me
      wlachance
