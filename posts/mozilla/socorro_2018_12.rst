.. title: Socorro: December 2018 happenings
.. slug: socorro_2018_12
.. date: 2019-01-02 10:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

At Mozilla, December is a rough month to get anything done, but we accomplished
a bunch anyways!


.. TEASER_END

Staff in December
=================

Me.


Highlights of December
======================

December is hard to get anything done because we have the All Hands for a week,
there's a bunch of next-year planning, and everyone takes PTO at the end of the
month which means there's a code-freeze for half the month during which nothing
can get pushed to production.

Despite this, we got stuff done:

* Miles upgraded Socorro to Postgres 9.5 and then 9.6. (:bz:`1497956`,
  :bz:`1497957`)

* Removed the React cupcake scaffolding. (:bz:`1514294`)

* Finished the Python 3 migration. Socorro is no longer using Python 2. I
  landed this on -stage and we'll push it to -prod in 2019. (:bz:`1406703`)

* Signature generation fixes.

* Documentation updates and changes.

* Handled PII access requests.


We're now using Python 3! Yay!

I think the next project is going to be upgrading Elasticsearch. That's the last
big technical debt project in the queue.


Bugzilla and GitHub stats for December
======================================

::


    Period (2018-12-01 -> 2018-12-31)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 25
      Creators: 7
    
           Will Kahn-Greene [:willkg] ET  : 16
           Marcia Knous [:marcia - needin : 2
            Dragana Damjanovic [:dragana] : 1
           Julien Cristau [:jcristau] [PT : 1
                Andrew McCreight [:mccr8] : 1
           Kartikaya Gupta (email:kats@mo : 1
                   Tom Tung [:tt, :ttung] : 1
    
      Bugs resolved: 35
    
                                  WONTFIX : 5
                                    FIXED : 26
                               WORKSFORME : 1
                               INCOMPLETE : 1
                                  INVALID : 1
                                DUPLICATE : 1
    
      Resolvers: 10
    
               Will Kahn-Greene [:willkg] : 24
                   Miles Crabill [:miles] : 2
           Alexis Deschamps [:alexisdesch : 2
               Peter Bengtsson [:peterbe] : 2
                                  rhelmer : 1
           Michael Kelly [:mkelly,:Osmose : 1
              Marco Castelluccio [:marco] : 1
           Ted Mielczarek [:ted] [:ted.mi : 1
               Julien Cristau [:jcristau] : 1
    
      Commenters: 25
    
                                   willkg : 106
                        mozilla+bugcloser : 24
                                  peterbe : 12
                                    miles : 5
                               adeschamps : 5
                                   mkelly : 4
                               viveknegi1 : 3
                                     kats : 3
                      mozillamarcia.knous : 3
                                  cmiller : 2
                            mcastelluccio : 2
                                      ted : 2
                               dd.mozilla : 2
                                 jcristau : 2
                                  rhelmer : 1
                                    kairo : 1
                                     mats : 1
                          alexbruceharley : 1
                                   adrian : 1
                             chris.lonnen : 1
                                  susingh : 1
                                    vnegi : 1
                                   bpitts : 1
                                    atoll : 1
                              sdeckelmann : 1
    
      Tracker bugs: 4
    
          1406703: [tracker] switch to python 3
          1497956: [tracker] upgrade postgres to 9.5
          1497957: [tracker] upgrade postgres to 9.6
          1505231: [tracker] rework error handling in processor
    
      Statistics
    
          Youngest bug : 0.0d: 1512633: archivescraper misses ESR builds
       Average bug age : 164.5d
        Median bug age : 37.0d
            Oldest bug : 1739.0d: 981860: add "Gonk" and "Android" to list of supported OSes
    
    GitHub
    ======
    
      mozilla-services/antenna: 0 prs
    
    
      mozilla-services/socorro: 21 prs
    
        Committers:
                   willkg :    19  ( +5874, -15613,  159 files)
               amccreight :     1  (    +1,     -0,    1 files)
                 jcristau :     1  (    +1,     -0,    1 files)
    
                    Total :        ( +5876, -15613,  161 files)
    
        Most changed files:
          webapp-django/package-lock.json (4)
          socorro/cron/jobs/archivescraper.py (4)
          Makefile (3)
          socorro/signature/tests/test_rules.py (3)
          webapp-django/package.json (3)
          socorro/processor/mozilla_transform_rules.py (3)
          requirements/default.txt (3)
          docker-compose.yml (3)
          docker/Dockerfile (3)
          webapp-django/crashstats/crashstats/utils.py (3)
    
        Age stats:
              Youngest PR : 0.0d: 4756: fix bug 1516010: add version flow docs
           Average PR age : 0.3d
            Median PR age : 0.0d
                Oldest PR : 3.0d: 4738: bug 1507186: get all the webapp tests passing
    
      mozilla-services/socorro-pigeon: 0 prs
    
    
    
      All repositories:
    
        Total merged PRs: 21
    
    
    Contributors
    ============
    
      adrian
      alexbruceharley
      Alexis Deschamps [:alexisdeschamps]
      Andrew McCreight [:mccr8]
      atoll
      Brian Pitts
      Lonnen
      cmiller
      dd.mozilla
      Dragana Damjanovic [:dragana]
      Julien Cristau [:jcristau]
      kairo
      Kartikaya Gupta
      Marcia Knous [:marcia - needinfo? me]
      Marco Castelluccio [:marco]
      mats
      Michael Kelly [:mkelly,:Osmose]
      Miles Crabill [:miles]
      mozilla+bugcloser
      Peter Bengtsson [:peterbe]
      rhelmer
      sdeckelmann
      susingh
      Ted Mielczarek [:ted] [:ted.mielczarek]
      Tom Tung [:tt, :ttung]
      viveknegi1
      Will Kahn-Greene [:willkg] ET needinfo? me
