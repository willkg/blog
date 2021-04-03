.. title: Socorro in 2018
.. slug: socorro_2018
.. date: 2019-01-03 12:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

2018 was a **big** year for Socorro. In this blog post, I opine about our
accomplishments.


.. TEASER_END

Highlights 2018
===============

2018 was a big year. I really can't overstate that. Some highlights:

* **Switched from Google sign-in to Mozilla's SSO.**

  Alexis (one of our summer interns) switched the Crash Stats site from Google
  sign-in to Mozilla's SSO. It fixed a ton of problems we've had with sign-in
  over the years and brings Crash Stats into the fold along with other Mozilla
  sites.

  It also created a couple of new problems which I'm still working out. The big
  one being "Periodic 'An unexpected error occurred' when browsing reports and
  comments" (:bz:`1473068`).

* **Redid our AWS infrastructure.**

  This was a huge project that reworked everything about Socorro's
  infrastructure. Now we have:

  1. aggregated, centralized logs and log history
  2. CI-triggered deploys
  3. Docker-based services
  4. a local development environment that matches stage and prod server
     environments
  5. disposable nodes
  6. version-control managed configuration
  7. locked-down access to storage systems
  8. automatic scaling
  9. AWS S3 bucket names that don't have periods in them

  This project took a year and a half to do and simplified deploying and
  maintaining the project significantly. It also involved rewriting a lot of
  stuff.

  I talk more about this project in :doc:`Socorro Smooth Mega-Migration 2018
  <socorro_migration_2018>`.

  We did a fantastic job on this--it was super smooth!

* **Rewrote Socorro's signature generation system.**

  Early this summer, Will Lachance took on Ben Wu as an intern to look at
  Telemetry crash ping data. One of the things Ben wanted to do was generate
  Socorro-style signatures from the data. Then he could do analysis on crash
  ping data using Telemetry tools and do deep dives on specific crashes in
  Socorro.

  I refactored and extracted Socorro's signature generation code into a Python
  library that could be used outside of Socorro.

  I talk more about this project in :doc:`Siggen (Socorro signature generator) v0.2.0
  released! <siggen_0_2_0>`.

  After Ben finished up his internship, the project was shut down. I don't think
  anyone uses the Siggen library. Ted says if we make it a web API, then people
  could use it in other places. That's the crux of "Add a web API to generate a
  signature from a list of frames" (:bz:`828452`). I want to work on that, but
  have to hone the signature generation API more first.

  I also cleaned up a bunch of signature generation removing one of the siglist
  files we had, generalizing some of the code, and improving signature
  generation in several cases.

* **Tried out React.**

  Mike and Alexis investigated switching the Crash Stats front end to React.
  Towards that, they tested out converting the report view to a React to see
  how it felt, what problems it solved, and what new issues came up.

  Alexis ended his summer internship and Mike switched to a different project,
  so I spent some time mulling over things and deciding that while I like React
  and there are some compelling reasons to React-ify Crash Stats, this isn't a
  good move right now.

* **Reworked Socorro to support new products.**

  I reworked processing and the web interface to allow Socorro to support
  products that don't have the same release management process as Firefox and
  Fennec.

  Now Socorro supports Focus, FirefoxReality, and the GeckoView
  ReferenceBrowser.

* **Switched from FTPScraperCronApp to ArchiveScraperCronApp.**

  Incoming crash reports for the beta channel report the release version and not
  the beta version. For example, crash reports for "64.0b4" come in saying
  they're for "64.0". That's tough because then it's hard to group crashes by
  specific beta. Because of that, the processor has a ``BetaVersionRule``
  which looks up the (product, channel, buildid) in a table and pulls out the
  version string for all incoming crash reports in the beta channel.

  Previously, "a table" was a set of tables containing product build/version
  data. It was populated by ``FTPScraperCronApp`` which scraped
  ``archive.mozilla.org`` every hour for build information. It would pass the
  build information through a series of stored procedures and magically data
  would appear in the table [1]_. Most of this code was written many years ago
  and didn't work with recent changes to releases like release candidates and
  aurora.

  I rewrote the ``BetaVersionRule`` to do a lookup on Buildhub. However, we hit
  a bunch of issues that I won't go into among which is that the data in
  Buildhub doesn't have exactly what we need for the ``BetaVersionRule`` to
  do its thing correctly.

  So I wrote a new ``ArchiveScraperCronApp`` that scrapes
  ``archive.mozilla.org`` for the data the ``BetaVersionRule`` needs to
  correctly find the version string. It now handles release candidates correctly
  and also aurora.

  .. [1] And sometimes, data wouldn't appear in the table for magical and
     inexplicable reasons, too.

* **Removed PostgreSQL from the processor; removed alembic, sqlalchemy, and
  everything they managed.**

  For years, Socorro engineering team worked on cleaning up the Gormenghast-like
  sprawl that was postgres. For years, we've been generating PR after PR
  tweaking things and removing things to reduce the spaghetti morass. It was
  like removing a mountain with a plastic beach toy.

  All that has come to an end.

  https://github.com/mozilla-services/socorro/pull/4723

  We now have one ORM. We now have one migration system. We no longer have
  stored procedures or other bits that lack unit tests and documentation. We
  also bid farewell to ftpscraper and that data flow of build/release
  information that could have been a character or a setting in a Clive Barker
  novel. This gets rid of a bunch of things that were really hard to maintain
  and never worked quite right.

  While I did the final PR, all the work I did built upon work Adrian and Peter
  and other people did over the years. Yay us!

* **Migrated to Python 3.**

  I started the Python 3 migration project a couple of years ago because
  the death knell for Python 2 had sounded and time was ticking.

  We did this work in a series of baby steps so that we could make progress
  incrementally without upsetting or blocking other development initiatives. In
  the process of doing this, we updated and rewrote a lot of code including most
  of the error handling in the processor.

  I talk more about this project in :doc:`Socorro: migrating to Python 3
  <socorro_python3>`.

  This was a big deal. Python 3 is sooooo much easier to deal with. Plus some
  of the libraries we're using or are planning to use are dropping support for
  Python 2 and things were going to get increasingly irksome.

  Big thanks to Ced, Lonnen, and Mike for their efforts on this!

* **Removed ADI and ADI-related things.**

  Socorro used ADI to normalize crash rates in a couple of reports. There were
  tons of problems with this. Now we have Mission Control which does a better
  job with rates and normalizing and has more representative crash data, too.

  Thus, we removed the reports from Socorro and also all the code we had to
  fetch and manage ADI data.

* **Stopped saving crash reports that won't get processed.**

  Socorro was saving roughly 70% of incoming crash reports over half of which it
  wasn't processing. That was problematic because it meant we had a whole bunch
  of crash report data in storage that we didn't know anything about. That's one
  of the reasons we had to drop all the crash report data back in December
  2017--we couldn't in a reasonable amount of time figure out which crash
  reports were ok to keep and which had to go.

  Now Socorro saves and processes roughly 20% of incoming crash reports and
  rejects everything else.

  Note that this doesn't affect users--they can still go to ``about:crashes``
  and submit crash reports and those will get processed just like before.

* **Removed a lot of code.**

  In 2017, we removed a lot of code. We did the same in 2018.

  At the beginning of 2018, we had this::

      --------------------------------------------------------------------------------
      Language                      files          blank        comment           code
      --------------------------------------------------------------------------------
      Python                          401          12447          10881          61034
      C++                              11            816            474           6052
      HTML                             66            695             24           5167
      JavaScript                       52            904            959           4926
      JSON                             88             21              0           4432
      LESS                             19            146             49           2614
      SQL                              67            398            333           2242
      C/C++ Header                     12            322            614           1259
      Bourne Shell                     36            298            366           1094
      CSS                              13             55             65           1012
      MSBuild script                    3              0              0            463
      YAML                              4             34             44            241
      Markdown                          3             69              0            187
      INI                               4             27              0            120
      make                              3             31             14             96
      Mako                              1             10              0             20
      Bourne Again Shell                1              7             13             13
      Dockerfile                        1              4              2             11
      --------------------------------------------------------------------------------
      SUM:                            785          16284          13838          90983
      --------------------------------------------------------------------------------


  At the end of 2018, we had this::

      ------------------------------------------------------------------------------
      Language                     files          blank        comment           code
      -------------------------------------------------------------------------------
      Python                         296           8493           6708          41107
      C++                             11            827            474           6095
      JSON                            92             21              0           4296
      HTML                            50            484             19           4270
      JavaScript                      37            624            773           3368
      LESS                            36            287             51           2712
      C/C++ Header                    12            322            614           1259
      CSS                              3             27             53            704
      MSBuild script                   3              0              0            463
      Bourne Shell                    21            173            263            449
      YAML                             3             28             33            226
      make                             3             36             15            142
      Dockerfile                       1             14             12             35
      INI                              1              0              0              8
      -------------------------------------------------------------------------------
      SUM:                           569          11336           9015          65134
      -------------------------------------------------------------------------------


  We're doing roughly the same stuff, but with less code.

  I don't think we're going to have another year of drastic code reduction, but
  it's likely we'll remove some more in 2019 as we address the last couple of
  technical debt projects.

* **Improved documentation.**

  I documented data flows and services. That helps maintainers and future me
  going forward.

  I documented how to request access to PII/memory dumps. The former wasn't
  documented and sure seemed like any time an engineer needed elevated access,
  he/she would stumble around to figure out how to get it. That stinks.
  Hopefully it's better now.

  I also documented how to request a new product in Crash Stats. Socorro is
  effectively a service for other parts of the organization and it should have
  documentation covering the kinds of things services have: a list of what it
  does, how to use it, how to set your product up, etc. Getting there.


Lots of stuff happened. A lot of big multi-year projects were completed. It was
a good year!


Thank you!
==========

Thank you to everyone who helped out: Lonnen, Miles, Brian, Stephen, Greg, Mike,
and Will, our two interns Ced and Alexis, and everyone who submits bugs, PRs,
and helps out in their own ways!

We accomplished a ton this year. We're almost done with technical debt projects.
2019 will be fruitful.


Bugzilla and GitHub stats for 2018
==================================

::

    Period (2018-01-01 -> 2018-12-31)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 623
      Creators: 67
    
               Will Kahn-Greene [:willkg] : 349
               Peter Bengtsson [:peterbe] : 38
           Michael Kelly [:mkelly,:Osmose : 29
               Stephen Donner [:stephend] : 16
           Alexis Deschamps [:alexisdesch : 16
                              Brian Pitts : 13
                   Marcia Knous [:marcia] : 13
                   Miles Crabill [:miles] : 10
               Andy Mikulski [:amikulski] : 9
               Calixte Denizet (:calixte) : 8
                          Kartikaya Gupta : 8
                Andrew McCreight [:mccr8] : 7
                               [:philipp] : 6
                      Wayne Mery (:wsmwk) : 4
           Ted Mielczarek [:ted] [:ted.mi : 4
                           Lonnen :lonnen : 4
              Chris Peterson [:cpeterson] : 4
                   Jonathan Watt [:jwatt] : 3
           Jan Andre Ikenmeyer [:darkspir : 3
                   Cristi Fogel [:cfogel] : 3
                    Aaron Klotz [:aklotz] : 2
               Jeff Muizelaar [:jrmuizel] : 2
                 Markus Stange [:mstange] : 2
                     Liz Henry (:lizzard) : 2
                                  cmiller : 2
                 Paul Theriault [:pauljt] : 2
                Brian Hackett (:bhackett) : 2
               Julien Cristau [:jcristau] : 2
                     Treeherder Bug Filer : 1
            Peter Van der Beken [:peterv] : 1
                                Arun babu : 1
                     Tristan Weir [:weir] : 1
                   David Bolter [:davidb] : 1
                     Eric Rescorla (:ekr) : 1
                            Yasin Soliman : 1
                       AJ Bahnken [:ajvb] : 1
           Dan Glastonbury (:kamidphish)  : 1
                           Worcester12345 : 1
                Ted Campbell [:tcampbell] : 1
                Matthew Gregan [:kinetik] : 1
                             Suriti Singh : 1
                Johan Lorenzo [:jlorenzo] : 1
                             Adolfo Jayme : 1
                  Tom Prince [:tomprince] : 1
                  Mike Hommey [:glandium] : 1
                     David Baron :dbaron: : 1
              Marco Castelluccio [:marco] : 1
                            Ehsan Akhgari : 1
                  Stephen A Pohl [:spohl] : 1
                     Tim Smith [:tdsmith] : 1
                 Daosheng Mu[:daoshengmu] : 1
                          Rob Wu [:robwu] : 1
                   Randell Jesup [:jesup] : 1
                  Hiroyuki Ikezoe (:hiro) : 1
              Cameron McCormack (:heycam) : 1
                    Julien Vehent [:ulfr] : 1
           James Willcox (:snorp) (jwillc : 1
                           kiavash.satvat : 1
                      Jan Henning [:JanH] : 1
           Sebastian Kaspari (:sebastian) : 1
                  Yaron Tausky [:ytausky] : 1
                                    Atoll : 1
                   Andreas Farre [:farre] : 1
               Gabriele Svelto [:gsvelto] : 1
           Petru-Mugurel Lingurar[:petru] : 1
            Dragana Damjanovic [:dragana] : 1
                   Tom Tung [:tt, :ttung] : 1
    
      Bugs resolved: 781
    
                                  WONTFIX : 93
                               INCOMPLETE : 16
                                    FIXED : 597
                               WORKSFORME : 23
                                  INVALID : 28
                                DUPLICATE : 20
                                          : 4
    
      Resolvers: 50
    
           Will Kahn-Greene [:willkg] ET  : 499
               Peter Bengtsson [:peterbe] : 70
           Miles Crabill [:miles] [also m : 50
           Michael Kelly [:mkelly,:Osmose : 35
                              Brian Pitts : 22
           Alexis Deschamps [:alexisdesch : 17
               Stephen Donner [:stephend] : 16
               Andy Mikulski [:amikulski] : 9
                     Issei Horie [:is2ei] : 7
                           Lonnen :lonnen : 7
           Ted Mielczarek [:ted] [:ted.mi : 7
                        mozilla+bugcloser : 5
                Andrew McCreight [:mccr8] : 3
              Kartikaya Gupta (email:kats : 3
               Calixte Denizet (:calixte) : 3
                                madperson : 2
                                 vseerror : 2
           Marco Castelluccio [:marco] (P : 2
                                  cmiller : 2
                                  rhelmer : 1
                             jimnchen+bmo : 1
                       JP Schneider [:jp] : 1
                                  sarentz : 1
                                   gguthe : 1
                                   nfroyd : 1
                    Aaron Klotz [:aklotz] : 1
                                 abahnken : 1
                                   lhenry : 1
                  Mike Hommey [:glandium] : 1
                                   dbaron : 1
                               [:philipp] : 1
              Chris Peterson [:cpeterson] : 2
           Sotaro Ikeda [:sotaro out of o : 1
                                  mstange : 1
                      mozillamarcia.knous : 1
              Cameron McCormack (:heycam) : 1
               Jeff Muizelaar [:jrmuizel] : 1
           Julien Cristau [:jcristau] [PT : 1
    
      Commenters: 175
    
                                   willkg : 2297
                                  peterbe : 442
                        mozilla+bugcloser : 435
                                    miles : 161
                                   mkelly : 123
                                   bpitts : 123
                                      ted : 93
                             chris.lonnen : 77
                                   adrian : 59
                           stephen.donner : 50
                                      etc...
    
      Tracker bugs: 17
    
          1083384: [tracker] deprecate /status/ telemetry machinery
          1257531: [tracker] Stop saving crash data to postgresql
          1316435: [tracker][e2e-tests] Find a remedy for the skipped and
            xfail'd e2e-tests
          1346883: [tracker] remove postgres usage from processor
          1361394: [tracker] Simplify and clean up postgresql schema
          1373997: [tracker] rewrite docs
          1391034: [tracker] switch to dockerized socorro in cloudops
            infra
          1395647: [tracker] Migrate uploaders from Socorro to Tecken
          1406703: [tracker] switch to python 3
          1408041: [tracker] expose MinidumpSha256Hash
          1433274: [tracker] Photon: Refactor webapp UI styling and
            structure
          1478110: [tracker] stop saving crash data we aren't processing
          1478351: [tracker] support rust
          1478353: [tracker] support new products on Socorro
          1497956: [tracker] upgrade postgres to 9.5
          1497957: [tracker] upgrade postgres to 9.6
          1505231: [tracker] rework error handling in processor
    
      Statistics
    
          Youngest bug : 0.0d: 1429209: Switch from msgpack-python to msgpack
       Average bug age : 207.8d
        Median bug age : 18.0d
            Oldest bug : 3028.0d: 578760: Allow (manual) annotation of system graphs with...
    
    GitHub
    ======
    
      mozilla-services/antenna: 25 prs
    
        Committers:
                   willkg :    22  (  +944,   -901,   22 files)
             milescrabill :     3  (  +104,   -102,    3 files)
    
                    Total :        ( +1048,  -1003,   25 files)
    
        Most changed files:
          antenna/throttler.py (12)
          tests/unittest/test_throttler.py (8)
          antenna/breakpad_resource.py (4)
          tests/unittest/test_breakpad_resource.py (4)
          requirements/default.txt (3)
          .circleci/config.yml (3)
          docs/breakpad_reporting.rst (2)
          tests/unittest/test_s3_crashstorage.py (2)
          Dockerfile (2)
          tests/unittest/test_crashstorage.py (2)
    
        Age stats:
              Youngest PR : 0.0d: 286: Update requests to 2.20.0
           Average PR age : 1.5d
            Median PR age : 0.0d
                Oldest PR : 20.0d: 260: Update docs on triggering a crash in Firefox
    
      mozilla-services/socorro: 453 prs
    
        Committers:
                   willkg :   328  (+36325, -82912,  812 files)
            stephendonner :    27  (  +686,  -2426,   32 files)
                   Osmose :    26  ( +7429,  -1830,  120 files)
          AlexisDeschamps :    19  (+14081,  -9398,  166 files)
                 pyup-bot :     9  (  +779,   -724,    8 files)
                    is2ei :     7  (  +110,   -516,   16 files)
             andymikulski :     7  ( +2468,  -2182,   73 files)
                   lonnen :     5  (  +461,  -6378,   71 files)
             milescrabill :     4  (   +44,    -74,    3 files)
               amccreight :     3  (    +3,     -0,    3 files)
               ceddy-cedd :     3  (  +171,    -74,   49 files)
            renovate[bot] :     3  ( +1490,   -814,    5 files)
                 jcristau :     2  (    +2,     -1,    2 files)
                 jrmuizel :     1  (    +2,     -0,    1 files)
                   heycam :     1  (    +1,     -0,    1 files)
              sotaroikeda :     1  (    +1,     -0,    1 files)
                 cpeterso :     1  (    +1,     -0,    1 files)
             philipp-sumo :     1  (    +1,     -0,    1 files)
                  sciurus :     1  (    +0,     -2,    1 files)
                    luser :     1  (    +2,     -1,    1 files)
                      g-k :     1  (    +1,     -1,    1 files)
                  dblohm7 :     1  (  +172,    -49,    3 files)
                 chartjes :     1  (    +0,     -9,    2 files)
    
                    Total :        (+64230, -107391, 1015 files)
    
        Most changed files:
          socorro/processor/mozilla_transform_rules.py (44)
          webapp-django/crashstats/crashstats/models.py (37)
          requirements/default.txt (32)
          webapp-django/crashstats/settings/base.py (30)
          socorro/unittest/processor/test_mozilla_transform_rules.py (29)
          socorro/signature/rules.py (25)
          webapp-django/crashstats/crashstats/utils.py (25)
          socorro/cron/crontabber_app.py (23)
          Makefile (22)
          webapp-django/crashstats/settings/bundles.py (21)
    
        Age stats:
              Youngest PR : 0.0d: 4756: fix bug 1516010: add version flow docs
           Average PR age : 1.3d
            Median PR age : 0.0d
                Oldest PR : 72.0d: 4253: [ready] 1409648 gc rule sets part 2
    
      mozilla-services/socorro-pigeon: 10 prs
    
        Committers:
                   willkg :     9  (  +630,   -225,   22 files)
             milescrabill :     1  (    +1,     -1,    1 files)
    
                    Total :        (  +631,   -226,   22 files)
    
        Most changed files:
          README.rst (4)
          pigeon.py (4)
          bin/build_artifact.sh (3)
          requirements-dev.txt (3)
          tests/conftest.py (3)
          Makefile (2)
          tests/test_pigeon.py (2)
          circle.yml (2)
          setup.cfg (2)
          .gitignore (1)
    
        Age stats:
              Youngest PR : 0.0d: 37: bug 1452681 - artefact 2
           Average PR age : 1.3d
            Median PR age : 0.0d
                Oldest PR : 6.0d: 34: bug 1432491 - redo aws lambda scaffolding
    
    
      All repositories:
    
        Total merged PRs: 488
    
    
    Contributors
    ============
    
      Atoll
      Ehsan Akhgari
      [:philipp]
      Aaron Klotz [:aklotz]
      abahnken
      acrichton
      adityamotwani
      Adolfo Jayme
      adrian
      afarre
      AJ Bahnken [:ajvb]
      ajones
      akimov.alex
      alex_mayorga
      alexbruceharley
      Alexis Deschamps [:alexisdeschamps]
      almametcal
      Andreas Farre [:farre]
      Andrew McCreight [:mccr8]
      Andy Mikulski [:amikulski]
      apavel
      april
      Arun babu
      arunbalu123
      aryx.bugmail
      ayumiqmazaky
      bbirtles
      benjamin
      bewu
      bhackett1024
      bhearsum
      bloodyhazel7
      bobby.chien+bugzilla
      brad
      Brian Hackett (:bhackett)
      Brian Pitts
      bzhao
      Calixte Denizet (:calixte)
      cam
      Cameron McCormack (:heycam)
      catlee
      cdenizet
      ceddy-cedd
      chartjes
      Chris Peterson [:cpeterson]
      chutten
      cliang
      cmiller
      continuation
      cr
      Cristi Fogel [:cfogel]
      culucenk
      Dan Glastonbury (:kamidphish)
      Daosheng Mu[:daoshengmu]
      dave.hunt
      David Baron :dbaron:
      David Bolter [:davidb]
      dblohm7
      dbrown
      dd.mozilla
      ddurst
      dmajor
      dmu
      Dragana Damjanovic [:dragana]
      dteller
      dthorn
      dustin
      dveditz
      dylan
      ehsan
      emilio
      Eric Rescorla (:ekr)
      fbraun
      felash
      g-k
      Gabriele Svelto [:gsvelto]
      gdestuynder
      gfritzsche
      gguthe
      gijskruitbosch+bugs
      giles
      gps
      heycam
      Hiroyuki Ikezoe (:hiro)
      hkirschner
      hutusoru.andrei
      i17gyp
      igoldan
      Issei Horie [:is2ei]
      James Willcox (:snorp)
      Jan Andre Ikenmeyer [:darkspirit]
      Jan Henning [:JanH]
      jbecerra
      jclaudius
      jdow
      Jeff Muizelaar [:jrmuizel]
      jh+bugzilla
      jimb
      jimnchen+bmo
      jld
      Johan Lorenzo [:jlorenzo]
      John99-bugs
      Jonathan Watt [:jwatt]
      JP Schneider [:jp]
      jrmuizel
      jteh
      Julien Cristau [:jcristau]
      Julien Vehent [:ulfr]
      jwalker
      kairo
      Kartikaya Gupta
      kbrosnan
      key-mozillabugzilla2939-contact
      kiavash.satvat
      kinetik
      lars
      larsberg
      lassey
      laura
      Liz Henry (:lizzard) (PTO Dec 28)
      Lonnen :lonnen
      ludovic
      luser
      m_kato
      madperson
      Marcia Knous [:marcia - needinfo? me]
      Marco Castelluccio [:marco] (PTO until Jan 2)
      Markus Stange [:mstange] (away until Jan 8)
      markus.vervier
      mats
      matt.woodrow
      Matthew Gregan [:kinetik]
      mbrandt
      mconley
      mdaly
      merwin
      Michael Kelly [:mkelly,:Osmose]
      Mike Hommey [:glandium]
      miket
      milaninbugzilla
      Miles Crabill [:miles] [also mcrabill
      mozilla
      mozilla+bugcloser
      n.nethercote
      ncsoregi
      nfroyd
      nhirata.bugzilla
      nitanwar
      nkochar
      nthomas
      orangefactor
      overholt
      Paul Theriault [:pauljt]
      pbone
      Peter Bengtsson [:peterbe]
      Peter Van der Beken [:peterv]
      Petru-Mugurel Lingurar[:petru]
      ptheriault
      pulgasaur
      rail
      Randell Jesup [:jesup]
      rares.doghi
      rbarker
      rhelmer
      rkothari
      Rob Wu [:robwu]
      s.kaspari
      sarentz
      schalk.neethling.bugs
      sciurus
      sdaswani
      sdeckelmann
      Sebastian Kaspari (:sebastian)
      secreport
      sespinoza
      skywalker333
      sledru
      smani
      Sotaro Ikeda [:sotaro]
      sotaroikeda
      sphink
      Stephen A Pohl [:spohl]
      Stephen Donner [:stephend]
      Suriti Singh
      susingh
      svoisen
      Ted Campbell [:tcampbell]
      Ted Mielczarek [:ted] [:ted.mielczarek]
      Tim Smith [:tdsmith]
      Tobias.Besemer
      Tom Prince [:tomprince]
      Tom Tung [:tt, :ttung]
      Tristan Weir [:weir] -- use NEEDINFO for response
      videetssinghai
      viveknegi1
      Wayne Mery (:wsmwk)
      Will Kahn-Greene [:willkg] ET needinfo? me
      wlachance
      Worcester12345
      Yaron Tausky [:ytausky]
      Yasin Soliman
      yor
