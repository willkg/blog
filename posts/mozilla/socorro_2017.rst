.. title: Socorro in 2017
.. slug: socorro_2017
.. date: 2018-01-08 9:00
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

2017 was a **big** year for Socorro. In this blog post, I opine about our
accomplishments.


.. TEASER_END

Turnover in 2017
================

At the beginning of the year, we had three full-time developers. Then Adrian
left for Pontoon (a completely different project) and Peter left to continue
working on Tecken (all things symbols in Socorro) on another team. That left me
alone-ish for a month which was tough. Then we picked up Mike in October.

Throughout, Lonnen managed to find time to fix Socorro things and review PRs.
That alleviated some of the lack-of-critical-mass problems we had during the
year.

We also had a cadre of engineers and other people who contributed fixes mostly
around signature generation.

That's a lot of turnover for a very very small team. At one point, I was the
only developer which was really hard because Socorro is a huge code base. We
made due and still did great things.


Highlights 2017
===============

2017 was a big year. I really can't overstate that. Despite the turnover, we
accomplished a lot. Some highlights:

* **Replaced the Socorro collector.** Replaced the Socorro collector with a
  top-to-bottom rewrite code-named Antenna. We put it in production in April 2017
  and fixed a few minor issues that came up. We haven't touched it since then--it's
  been solid.

  In July, I wrote a :doc:`post-mortem and project wrap-up
  <antenna_project_wrapup>`.

  Ops, QA, engineering--we did awesome on this project!

* **Created a new Docker-based local development environment.** This radically
  improved our ability to trouble-shoot, debug, reproduce issues, fix issues,
  and verify correctness of fixes. It was a game-changer.

  In September, I wrote :doc:`Socorro local development environment
  <socorro_dev_env>`.

* **Rewrote signature generation code and added a command line interface.** This
  allows us to verify signature generation changes and experiment with new ones.
  We can confidently make changes to signature generation code now and know
  roughly what the effects will be.

  Not only that, but the tools are easy to use and make it possible for anyone
  to test their signature generation changes.

  In October, I wrote :doc:`socorro_signature_generation`.

* **Built a new Docker-based -stage environment.** Our current infrastructure
  has some rough edges and it's really different than the other systems at
  Mozilla. In order to be more like other systems, we're building a new
  infrastructure for Socorro that uses Ops-preferred Dockerflow bits. This new
  infrastructure will make it easier to scale individual components, deploy,
  back out deploys, and manage everything.

  Getting a working -stage environment was a huge accomplishment. From writing
  Docker files and new command scripts, to infrastructure glue and deploy
  pipeline bits, to getting everything including our tests working on Circle CI,
  to rewriting Socorro code that had underlying assumptions about how it was
  being run to work with the new system.

  Work for this ongoing project is covered in :bz:`1391034` and a bunch of bugs
  blocking that one.

* **Rewrote Snappy symbolification server and all things symbols.** We rewrote
  the Snappy symbolification server which engineers use to symbolicate stacks to
  get meaningful stack traces. This new system is code-named Tecken.

  In addition to that, Peter took the project several steps further and
  centralized all things symbols into Tecken.

  Socorro's minidump stackwalker now asks Tecken for symbol lookups allowing
  Tecken to keep track of missing symbols. Soon, we'll be able to remove all the
  missing symbol bookkeeping code from Socorro.

  We're also switching to Tecken for symbol uploads. Soon, we'll be able to
  remove all the symbol upload code from Socorro, too.

  Peter wrote a plog entry on `load testing Tecken
  <https://www.peterbe.com/plog/tecken-load-testing>`_ which covers some other
  bits about Tecken as well.

* **Removed lots of code and other things from the repository.** Adrian and
  Peter worked on the "deprecation rampage" focusing on removing unused API
  endpoints. We spent time removing Postgres tables, stored procedures, and
  views we weren't using. We removed the fakedata generation code. We removed
  the middleware component (most of it was folded into the webapp). We removed
  the aging and broken Vagrant development environment. We removed a bunch of
  scripts whose purpose has long been forgotten. We removed code for cron jobs
  we no longer run. We removed bits and bobs for projects long abandoned
  (running Socorro on Heroku, using hbase, etc).

  There's still a lot of code ripe for removal and cleaning up, but we made
  significant progress towards reducing the code base to a size that's
  maintainable by a small team.

  This is covered by a bunch of bugs like :bz:`1361394`, :bz:`1314814`,
  :bz:`1424027`, :bz:`1424370`, :bz:`1398946`, and :bz:`1387493`.

* **Updated Python dependencies and reworked how we manage them.** We
  updated all the Python dependencies (some of which were several years old),
  switched to a requirements file and constraints file to specify them, and set
  up monthly dependency reviews for non-security updates and daily dependency
  reviews for security updates.

  This automates the majority of the work required to stay up-to-date.

  This work is covered in :bz:`1306731`.

* **Updated JavaScript dependencies and switched to npm to manage them.** Our
  webapp relies on a bunch of JavaScript libraries. We had copies of these
  libraries in the repository. We removed the vendored copies and switched to
  npm to install them from a requirements file. Additionally, the updated the
  dependencies to more recent versions and set up monthly review for updates.

  This work is covered in :bz:`1388593`.

* **Built better metrics infrastructure for the webapp.** We switched the webapp
  to use a library I wrote for Antenna called `Markus
  <https://markus.readthedocs.io/>`_. This makes it much easier to measure
  things like how often API endpoints are being used. Adding metrics to the
  webapp is now a two-line code-change.

  I want to update the rest of Socorro in similar ways. Hopefully, I can get to
  that in early 2018.

  This work is covered in :bz:`1412590`.

* **Cleaned up bugs.** We triaged and resolved 1,221 bugs. We resolved bugs that
  were obsolete, for projects we abandoned, fixed, and otherwise not helpful
  anymore. We're down to under 500 bugs now.

* **Switched from nose to pytest.** We switched from nose to pytest. We have
  hundreds of tests, so this was an overhaul of our test code which took a
  while. The end result is that we're now using a test library that has features
  that will make writing and maintaining tests much easier.

  This is covered in :bz:`1361764` and :bz:`1405675`.

* **Linted Python code and added linting to CI.** We linted all the Python code,
  fixed issues, and added linting to our CI. Linting is an important tool for
  finding certain classes of bugs. Being able to lint in CI reduces the risk of
  code changes.

  This is covered in :bz:`1377254`.

* **Overhauled documentation.** We overhauled the documentation. We now have a
  new `Getting Started
  <https://socorro.readthedocs.io/en/latest/gettingstarted.html>`_ guide that
  gets you a local development environment in roughly 4 steps. It documents the
  scripts we use for manipulating that environment and running the various
  components of Socorro individually as well as in conjunction with other
  components.

  We also updated all the documentation related to administrating and
  maintaining the infrastructure.

  There's still a lot of work to do here, but we made significant progress.

* **Wrote a system checklist.** We wrote up a system checklist for verifying
  that the entire system is working as expected. This is helpful after big
  changes like upgrading Python versions or critical libraries.

  This also gives us a list of important things in the system so we can automate
  verification as much as possible and change parts that are hard to verify.

* **Radically reduced onboarding time for new developers.** When I started in
  2016, it took me more than 6 months before I was up-to-speed and had a working
  development environment enough to be productive.

  Contrast that experience with Mike who was up-to-speed in a few weeks.


It was a good year!


Lowlights 2017
==============

We had a bunch of highlights, but we also had some low lights:

* **Elasticsearch cluster upgrade fails.** We've been having problems with our
  Elasticsearch cluster for a while now. In 2017, we tried several times to
  upgrade our Elasticsearch cluster from 1.4 to 5.1 hoping that this will
  alleviate some of our problems.

  We tried this in our -stage environment several times failing each time. This
  project was supposed to be pretty straight-forward, but it had complexities we
  didn't understand until later.

  First, we discovered we had a lot of problems in our data making it difficult
  to migrate it over. We have a **lot** of data, so we had to copy the data from
  one cluster to another cluster and transform it along the way. It's really
  difficult to do that quickly. We were mucking with Groovy script embedded in a
  reindex-from-remote command. The iteration cycle was rough, too--we'd run the
  script for a day and then discover more issues that we had to fix.

  Second, we had to rewrite and update a lot of code and our testing had a lot
  of holes in it. We'd get some things working in -stage only to discover new
  issues.

  Since we have only one -stage environment, these experiments blocked all
  Socorro development.

  After the third abandoned attempt, I suggested we back up a step and build a
  local development environment with both Elasticsearch cluster versions, test
  everything out there, and work out the issues. Meanwhile, we can fix some of
  our data problems which is probably a good idea anyhow.

  Meanwhile, we're also trying to redo our infrastructure. We have a really
  small team. We can't do two big projects like this at the same time. I
  reprioritized them a few times hoping we could get one of them done and reduce
  the number of big projects we were juggling. I think that only made things
  worse.

  That work is being done in :bz:`1322630`.

* **Another year with Postgres crash storage.** The Socorro processor
  processes a raw crash into a processed crash and then saves it to a bunch of
  crash stores. We've been trying to remove Postgres from the crash store
  destinations.

  This work has been really hard. The code is really tangled and slides between
  Python-land and Postgres-stored-procedure-land. Some of it is well tested,
  but some of it has no tests at all and interesting side-effects.

  I thought we were really close to dropping Postgres as a crash store. I
  tried to pick up where Adrian and Peter left off, but essentially ran out of
  time in the year to finish this off.

  This work is being done in :bz:`1257531`.

* **Switch from ftpscraper to buildhub.** We currently have a script called
  ftpscraper that scrapes archive.mozilla.org for new and updated build
  information. It has a bunch of "interesting logic" for traversing the
  directory trees and interpreting the data. It then executes a bunch of stored
  procedures that convert that build information into some form and stores it in
  the database.

  Those stored procedures do interesting things. They handle a bunch of "one-off"
  scenarios in the build information some of which stem from goofs and some from
  the ever evolving Firefox build system. They also enforce invariants that
  aren't true anymore as far as I can tell. They have no tests.

  Socorro's system for accruing build information is really hard to debug. It
  takes days to understand how the data flowed and why weird things happened.
  Many issues are ephemeral, so they're not reproducible after the fact.

  Over the summer, `Buildhub <https://mozilla-services.github.io/buildhub/>`_
  was written and stood up to build and maintain a set of build data much like
  what we're getting with ftpscraper. I looked at dropping our ftpscraper script
  for a similar Buildhub-based script, but haven't had time to continue that
  work and keep pushing it off in order to finish other things. In the meantime,
  we continue to have problems with build information which we spend/waste gobs
  of time debugging.

  This work is being done in :bz:`1366301`.

* **Spent the bulk of our time addressing technical debt.** We worked through a
  lot of technical debt that had been accreting for years. That's great, but it
  was at the cost of spending time improving things that people use.

  We could have spent more time honing the Crash Stats webapp interface. We
  could have spent more time improving bits to make QA easier. We could have
  spent more time fixing our API documentation to make it more usable.

  There's never enough time to do everything, but it would be better if we had
  accomplished more user-facing things.


Hopefully, we get to these in 2018.


Thanks!
=======

Thank you to the Socorro team: Lonnen, Peter, Adrian, Matt, Miles, Grumpy, Greg,
Mike, and Will!

We accomplished a lot this year. We're in a really good position coming
into 2018.


Bugzilla and GitHub stats for 2017
==================================

::

    Bugzilla
    ========
    
      Bugs created: 876
      Creators: 108
    
               Peter Bengtsson [:peterbe] : 310
               Will Kahn-Greene [:willkg] : 217
               Adrian Gaudebert [:adrian] : 45
                   Miles Crabill [:miles] : 37
                           Lonnen :lonnen : 29
              Marco Castelluccio [:marco] : 17
               Calixte Denizet (:calixte) : 14
                Andrew McCreight [:mccr8] : 14
           Ted Mielczarek [:ted.mielczare : 12
                               [:philipp] : 11
            Jonathan Claudius [:claudijd] : 9
           Michael Kelly [:mkelly,:Osmose : 8
                      Wayne Mery (:wsmwk) : 7
           Tobias B. Besemer [:BesTo] (QA : 6
                        Benjamin Smedberg : 5
                              Aaron Klotz : 5
                   Matt Brandt [:mbrandt] : 4
                      Jim Mathies [:jimm] : 4
               Nicholas Nethercote [:njn] : 4
             Sylvestre Ledru [:sylvestre] : 4
               Stephen Donner [:stephend] : 3
                     David Baron :dbaron: : 3
                   Marcia Knous [:marcia] : 3
                        Greg Guthe [:g-k] : 3
           Cervantes Yu [:cyu] [:cervante : 2
           Jan Andre Ikenmeyer [:darkspir : 2
               Jeff Muizelaar [:jrmuizel] : 2
                 Robert Helmer [:rhelmer] : 2
                   Randell Jesup [:jesup] : 2
           Emilio Cobos Álvarez [:emilio] : 2
                 Markus Stange [:mstange] : 2
              Ryan VanderMeulen [:RyanVM] : 2
                      krysztofiak.jedrzej : 2
                          Kartikaya Gupta : 2
                     Josh Matthews [:jdm] : 2
                   David Keeler [:keeler] : 2
                    David Major [:dmajor] : 2
                   Jonathan Watt [:jwatt] : 2
                 Virtual_ManPL [:Virtual] : 2
                  Nathan Froyd [:froydnj] : 2
                 Andrew Osmond [:aosmond] : 2
                         Away for a while : 2
                    Caglar Ulucenk [:Cag] : 1
           Kyle Machulis [:qdot] [:kmachu : 1
                   Dimi Lee[:dimi][:dlee] : 1
                Kevin Brosnan [:kbrosnan] : 1
                    Daniel Thorn [:relud] : 1
                    Makoto Kato [:m_kato] : 1
                       Asa Dotzler [:asa] : 1
                  Thomas Nguyen[:tnguyen] : 1
                John Lin [:jolin][:jhlin] : 1
                                    Denis : 1
                                    Mieke : 1
                 Johannes Pfrang [:johnp] : 1
               Andrew Sutherland [:asuth] : 1
                 James Cheng[:JamesCheng] : 1
               Shawn Huang [:shawnjohnjr] : 1
               Carl Corcoran [:ccorcoran] : 1
                  Stephen A Pohl [:spohl] : 1
                      Rail Aliiev [:rail] : 1
                       Kilik Kuo [:kikuo] : 1
                 Chun-Min Chang[:chunmin] : 1
                       Bruce Sun [:brsun] : 1
                  Dave Townsend [:mossop] : 1
                 Adam Gashlin [:agashlin] : 1
                 Haik Aftandilian [:haik] : 1
                       Aaron Meihm [:alm] : 1
               J. Ryan Stinnett [:jryans] : 1
              Cameron McCormack (:heycam) : 1
                                 baffclan : 1
           Jan Alexander Steffens [:hefti : 1
                           kiavash.satvat : 1
                      Raja Uzair Abdullah : 1
             JW Wang [:jwwang] [:jw_wang] : 1
                 Julian Seward [:jseward] : 1
            Georg Fritzsche [:gfritzsche] : 1
                   Hector Zhao [:hectorz] : 1
                   Mike Conley (:mconley) : 1
                    Mats Palmgren (:mats) : 1
                Henri Sivonen (:hsivonen) : 1
           Chris Hartjes [:grumpy][:chart : 1
                                 zolenkoe : 1
                 Neerja Pancholi[:neerja] : 1
                      Jan Henning [:JanH] : 1
                       Eric Rahm [:erahm] : 1
                    Dave Hunt (:davehunt) : 1
                             Bobby Holley : 1
                       Tzuhao Kuo [:kaku] : 1
                  Ming-Chou Shih [:stone] : 1
                Ted Campbell [:tcampbell] : 1
                Nicolas B. Pierron [:nbp] : 1
                       Alastor Wu [:alwu] : 1
                   Paul Adenot (:padenot) : 1
                 Salvador Espinoza [:sal] : 1
                       Vincent Liu[:vliu] : 1
                       James Teh [:Jamie] : 1
           Anthony Hughes (:ashughes) [QA : 1
                    Justin Wood (:Callek) : 1
               Julien Cristau [:jcristau] : 1
                             alex_mayorga : 1
                    Astley Chen [:astley] : 1
           Emanuel Hoogeveen [:ehoogeveen : 1
            Jason Orendorff [:jorendorff] : 1
                   Frank Bertsch [:frank] : 1
                          Rob Wu [:robwu] : 1
               Gabriele Svelto [:gsvelto] : 1
                       Paul Bone [:pbone] : 1
                                  Susingh : 1
    
      Bugs resolved: 1221
    
                                          : 5
                                  INVALID : 74
                                    FIXED : 770
                                DUPLICATE : 27
                               WORKSFORME : 67
                               INCOMPLETE : 11
                                  WONTFIX : 267
    
      Resolvers: 52
    
               Peter Bengtsson [:peterbe] : 339
                           Lonnen :lonnen : 309
               Will Kahn-Greene [:willkg] : 297
               Adrian Gaudebert [:adrian] : 92
                   Miles Crabill [:miles] : 69
                        mozilla+bugcloser : 20
           Michael Kelly [:mkelly,:Osmose : 15
              Marco Castelluccio [:marco] : 15
                     Laura Thomson :laura : 9
                Andrew McCreight [:mccr8] : 7
           Ted Mielczarek [:ted.mielczare : 8
                       JP Schneider [:jp] : 4
                   Matt Brandt [:mbrandt] : 4
           Cervantes Yu [:cyu] [:cervante : 2
                     David Baron :dbaron: : 2
                        Greg Guthe [:g-k] : 2
                                      Eva : 1
                    Daniel Thorn [:relud] : 1
                      krysztofiak.jedrzej : 1
           Chris Hartjes [:grumpy][:chart : 1
                     Alex Keybl [:akeybl] : 1
               Nicholas Nethercote [:njn] : 1
                                 cdenizet : 1
                                  dkeeler : 1
                      mozillamarcia.knous : 1
                                sespinoza : 1
                                 baffclan : 1
                           Gabriela Thumé : 1
                                   aklotz : 1
                                 vseerror : 1
                             continuation : 1
                 Al Billings [:abillings] : 1
                      Vance Chen [:vchen] : 1
                David Anderson [:dvander] : 1
                                cpeterson : 1
               Stephen Donner [:stephend] : 1
                                  Virtual : 1
             Guillaume Destuynder [:kang] : 1
                              Alex Harley : 1
               Calixte Denizet (:calixte) : 1
                                   sledru : 1
                                 fbertsch : 1
               Julien Cristau [:jcristau] : 1
    
      Commenters: 282
    
                                   willkg : 1384
                                  peterbe : 1184
                        mozilla+bugcloser : 535
                             chris.lonnen : 382
                                   adrian : 334
                                    kairo : 220
                                    miles : 218
                                      ted : 214
                                 chofmann : 190
                                  rhelmer : 138
                              sdeckelmann : 125
                                    laura : 103
                                pulgasaur : 91
                            mcastelluccio : 82
                                 vseerror : 67
                                     lars : 63
                                  mbrandt : 60
                    schalk.neethling.bugs : 56
                                   mkelly : 56
                                 benjamin : 55
                           stephen.donner : 43
                             continuation : 39
                                     josh : 39
                             n.nethercote : 37
                      mozillamarcia.knous : 31
                               jschneider : 27
                                 jmathies : 23
                         nhirata.bugzilla : 23
                           Tobias.Besemer : 21
                                 alqahira : 21
                                madperson : 20
                                   gguthe : 20
                                 cdenizet : 20
                                jruderman : 19
                              deinspanjer : 18
                              scoobidiver : 18
                                 timeless : 15
                                jclaudius : 14
                                 nitanwar : 14
                                   dmajor : 14
                                   sledru : 14
                                      bob : 11
                               jmuizelaar : 11
                         anthony.s.hughes : 11
                               ozten.bugs : 10
                      krysztofiak.jedrzej : 10
                                    pbone : 9
                       ryansnyder.me+bugs : 9
                                   trevor : 9
                       spohl.mozilla.bugs : 9
                                      cyu : 9
                                   dbaron : 9
                                 jbecerra : 9
                                christian : 8
                         brandon+bugzilla : 8
                                   dthorn : 7
                                 griswolf : 7
                                    ehsan : 7
                                   felash : 7
                           jacob.benoit.1 : 7
                            john+bugzilla : 7
                                  gsvelto : 6
                              eziegenhorn : 6
                                      bwu : 6
                                 chartjes : 6
                                  aphadke : 6
                                 jcristau : 6
                                  dteller : 6
                                   aklotz : 6
                                   dmaher : 6
                                   catlee : 6
                                dtownsend : 5
                                 amuntner : 5
                                    ewong : 5
                                cpeterson : 5
                                 bhearsum : 5
                                   cchang : 5
                                     jdow : 5
                        emanuel.hoogeveen : 5
                                   rjesup : 5
                                    erahm : 5
                                  Virtual : 5
                                     mats : 5
                        samuel.sidler+old : 4
                                  dkeeler : 4
                                     bugs : 4
                                 bugzilla : 4
                                      bmo : 4
                                  aosmond : 4
                                    vchen : 4
                                     dlee : 4
                                    mreid : 4
                                    milan : 4
                              nihsanullah : 4
                                    jwatt : 4
                       bugzilla-graveyard : 4
                                   kechen : 4
                                   dburns : 4
                         justin.lebar+bug : 4
                                    kanru : 4
                                mbeltzner : 4
                                 zolenkoe : 4
                                gabithume : 4
                                   nfroyd : 4
                                    amraj : 4
                                 rob1weld : 4
                                  tnguyen : 4
                                  smooney : 4
                                 jmichae3 : 4
                                b56girard : 3
                                    sshih : 3
                                   m_kato : 3
                                  mstange : 3
                                     kaku : 3
                                tcampbell : 3
                                   lhenry : 3
                                    april : 3
                                      bas : 3
                                   dganov : 3
                                   ddurst : 3
                                sespinoza : 3
                                 hsivonen : 3
                                    jolin : 3
                                    zackw : 3
                            cooldipanks14 : 3
                                     brad : 3
                                  ludovic : 3
                                      joe : 3
                              bobbyholley : 3
                                     alwu : 3
                             rajauzair926 : 3
                                  mcoates : 3
                                 kbrosnan : 3
                             alex_mayorga : 3
                          vladan.bugzilla : 3
                             jan.steffens : 3
                             howareyou322 : 3
                                  dvander : 3
                                    bzhao : 3
                                   jmdesp : 2
                                   jryans : 2
                              mark.finkle : 2
                       antoine.mechelynck : 2
                                   wcosta : 2
                                    brsun : 2
                               mh+mozilla : 2
                                     kyle : 2
                          dchanm+bugzilla : 2
                                  aravind : 2
                                   mounir : 2
                                  curtisk : 2
                           zxspectrum3579 : 2
                                  bugmail : 2
                        nicolas.b.pierron : 2
                                      jan : 2
                                  jvehent : 2
                            chrisccoulson : 2
                                     coop : 2
                                 overholt : 2
                                      cww : 2
                                  jseward : 2
                                 baffclan : 2
                                    htsai : 2
                               dd.mozilla : 2
                             haftandilian : 2
                                dave.hunt : 2
                                     rail : 2
                                  frgrahl : 2
                          joseph.k.olivas : 2
                                   ryanvm : 2
                                 yfdyh000 : 2
                                 mwu.code : 2
                            jduell.mcbugs : 2
                                  ettseng : 2
                                     bebe : 2
                                     jteh : 2
                                   emilio : 2
                                   jwwang : 2
                                    kikuo : 2
                                npancholi : 2
                                  dveditz : 2
                                  scabral : 2
                           bugspam.Callek : 2
                                  padenot : 2
                              akimov.alex : 2
                          martijn.martijn : 2
                                   shaver : 2
                                 fbertsch : 2
                                     vliu : 2
                                   shuang : 2
                              mozillamary : 2
                                  jmartin : 2
                                    jeads : 2
                                 xstevens : 2
                                      liz : 2
                                       vm : 2
                                  mozilla : 2
                                     info : 1
                          alexbruceharley : 1
                                    mhoye : 1
                                 jdemooij : 1
                            yuhongbao_386 : 1
                                 cshields : 1
                        nicks.post.kessel : 1
                                      swu : 1
                              John99-bugs : 1
                                    jonas : 1
                                   rbryce : 1
                               hgschutte1 : 1
                                  susingh : 1
                                rmcguigan : 1
                                jcoppeard : 1
                                   jaymoz : 1
                                 agashlin : 1
                                   sphink : 1
                                    cbook : 1
                                     gary : 1
                                   huseby : 1
                          hutusoru.andrei : 1
                               wmccloskey : 1
                                    oremj : 1
                          stevedocherty97 : 1
                                     erik : 1
                                   jjones : 1
                                standard8 : 1
                                    jorgk : 1
                                  nothung : 1
                                   mzeier : 1
                          m.goleb+mozilla : 1
                                wildmyron : 1
                            jstenback+bmo : 1
                             bent.mozilla : 1
                                thuelbert : 1
                                 pulsebot : 1
                                      eva : 1
                              jwalden+bmo : 1
                                  nthomas : 1
                                 morgamic : 1
                                    smani : 1
                                sbennetts : 1
                               tobbi.bugs : 1
                                   kchang : 1
                                  apdavis : 1
                                  mdoglio : 1
                                   carlco : 1
                                      aki : 1
                                     glob : 1
                       robert.strong.bugs : 1
                                    chris : 1
                                     reed : 1
                                      rob : 1
                                   jujjyl : 1
                            fredmessinger : 1
                                   ameihm : 1
                                      cam : 1
                             skywalker333 : 1
                           trifandreialin : 1
                                  philipp : 1
                               gfritzsche : 1
                                  lmandel : 1
                 release-mgmt-account-bot : 1
                                 jonathan : 1
                                   jcheng : 1
                                   nelson : 1
                               jorendorff : 1
                                    alexk : 1
                                   akeybl : 1
                                  namachi : 1
                              vps.pacitan : 1
                                  dbolter : 1
                              rpappalardo : 1
                                  chutten : 1
                             robert.chira : 1
                                 rkothari : 1
                                alice0775 : 1
                              doug.turner : 1
                              gdestuynder : 1
                           kiavash.satvat : 1
                                     gerv : 1
                                  brandon : 1
                                  arielb1 : 1
                       deletesoftware+moz : 1
    
      Tracker bugs: 21
    
          579136: Duplicate crashes in Socorro [tracker]
          629086: Show aggregate reports with/without duplicates [tracker]
          726143: [tracker] Speeding up Postgres Search
          764672: [tracker] Remove references to the bugs table
          874650: [tracker] Refresh Socorro Test Suite
          966358: [tracker] Tests for stored procedure output
          981008: [tracker] Deprecate pDump
          1097891: [tracker] post-AWS optimizations
          1114576: [tracker] Remove all dependencies to the "reports" table
          1124749: [tracker] Eliminate product_info view
          1273657: [tracker] Publish public crash stats to the data platform
          1304902: [tracker] Remove correlations from Socorro
          1306731: [tracker] Don't be so behind on python dependencies
          1314814: [tracker] Deprecation Rampage
          1315258: [tracker] switch to antenna for incoming crashes
          1351302: [tracker] Remove GCCrashes
          1357444: [tracker] Remove obsolete cron jobs
          1373997: [tracker] rewrite docs
          1387104: [tracker] make running webapp and processor in docker
              environment useful
          1427117: [tracker] purge data associated with bug 1427111
    
      Statistics
    
          Youngest bug : 0.0d: 1329736: upload_file_minidump files should get...
       Average bug age : 632.3d
        Median bug age : 41.0d
            Oldest bug : 3419.0d: 425399: Allow querying by modules in crashing...


    GitHub
    ======
    
      mozilla-services/antenna: 105 prs
    
        Committers:
                   willkg :    95  ( +3601,  -2469,   58 files)
             milescrabill :     7  (   +28,    -17,    4 files)
                      g-k :     2  (   +10,     -2,    1 files)
                   lonnen :     1  (    +2,     -5,    2 files)
    
                    Total :        ( +3641,  -2493,   61 files)
    
        Most changed files:
          antenna/breakpad_resource.py (34)
          antenna/app.py (17)
          requirements.txt (12)
          antenna/throttler.py (10)
          tests/unittest/test_breakpad_resource.py (10)
          antenna/ext/s3/connection.py (10)
          antenna/util.py (9)
          antenna/sentry.py (8)
          Dockerfile (8)
          antenna/metrics.py (7)
    
        Age stats:
              Youngest PR : 0.0d: 250: updates buildid with new release candidates
           Average PR age : 0.3d
            Median PR age : 0.0d
                Oldest PR : 15.0d: 217: Bug 1356899: Upgrade to python 3.6.1
    
      mozilla-services/socorro: 355 prs
    
        Committers:
                   willkg :   182  (+27881, -847549,  795 files)
                  peterbe :    64  ( +7202,  -5831,  159 files)
            stephendonner :    23  (   +53,    -54,    4 files)
                   Osmose :    18  ( +2622, -15557,   81 files)
                   adngdb :    18  ( +7887, -10051,   69 files)
                   lonnen :     7  (  +447,  -3094,   16 files)
               amccreight :     6  (    +7,     -0,    2 files)
             milescrabill :     6  (   +51,    -31,    3 files)
                 davehunt :     5  (   +66,   -107,   10 files)
                  marco-c :     3  (   +58,     -6,    5 files)
                      g-k :     2  (    +7,     -5,    2 files)
              CervantesYu :     2  (  +101,     -4,    3 files)
               calixteman :     2  (    +2,     -0,    1 files)
                   Lehych :     2  (    +5,     -2,    1 files)
              nnethercote :     2  (  +251,    -10,    4 files)
                      jdm :     1  (    +2,     -1,    1 files)
                    jesup :     1  (    +1,     -0,    1 files)
            renovate[bot] :     1  (   +11,     -0,    1 files)
               ehoogeveen :     1  (    +2,     -0,    1 files)
                 jcristau :     1  (    +2,     -0,    1 files)
               Krispy2009 :     1  (    +1,     -1,    1 files)
                 jrmuizel :     1  (    +3,     -0,    1 files)
                  aosmond :     1  (    +1,     -0,    1 files)
                   dbaron :     1  (    +2,     -0,    1 files)
               mozsvcpyup :     1  (  +360,   -317,   37 files)
                 EricRahm :     1  (    +1,     -0,    1 files)
                 pyup-bot :     1  (   +27,    -20,    3 files)
                 chartjes :     1  (   +30,     -1,    3 files)
    
                    Total :        (+47083, -882641,  954 files)
    
        Most changed files:
          webapp-django/crashstats/settings/base.py (22)
          socorro/siglists/prefix_signature_re.txt (20)
          docker-compose.yml (19)
          requirements.txt (17)
          e2e-tests/tox.ini (15)
          Makefile (15)
          webapp-django/crashstats/crashstats/tests/test_views.py (12)
          socorro/unittest/processor/test_mozilla_transform_rules.py (11)
          socorro/external/es/super_search_fields.py (10)
          socorro/processor/mozilla_transform_rules.py (10)
    
        Age stats:
              Youngest PR : 0.0d: 4270: Update the e2e tests README
           Average PR age : 2.4d
            Median PR age : 0.0d
                Oldest PR : 126.0d: 3676: [DNM] Fixes bug 1342081 - Upgraded ES libraries...
    
      mozilla-services/tecken: 446 prs
    
        Committers:
                  peterbe :   264  (+41190, -19624,  235 files)
                 pyup-bot :   169  ( +1142,  -1210,    3 files)
             milescrabill :    11  (  +286,   -577,   24 files)
                   willkg :     1  (   +28,    -15,    2 files)
                      g-k :     1  (   +19,    -15,    5 files)
    
                    Total :        (+42665, -21441,  241 files)
    
        Most changed files:
          requirements.txt (193)
          tecken/settings.py (86)
          tecken/api/views.py (38)
          tests/test_upload.py (35)
          tests/test_download.py (35)
          tecken/upload/views.py (33)
          tecken/download/views.py (30)
          frontend/src/Uploads.js (28)
          tests/test_api.py (27)
          docker-compose.yml (25)
    
        Age stats:
              Youngest PR : 0.0d: 626: fixes bug 1426506 - Upgrade pytest to 3.3.1
           Average PR age : 1.3d
            Median PR age : 0.0d
                Oldest PR : 50.0d: 374: circleci 2.0, remove staticfrontend and dev con...
    
    
      All repositories:
    
        Total merged PRs: 906
    
   
    Contributors
    ============
    
      Aaron Klotz [:aklotz]
      [:philipp]
      Aaron Meihm [:alm]
      Adam Gashlin [:agashlin]
      Adrian Gaudebert [:adrian]
      aki
      akimov.alex
      Al Billings [:abillings]
      Alastor Wu [:alwu]
      Alex Harley
      Alex Keybl [:akeybl]
      alex_mayorga
      alexbruceharley
      alexk
      alice0775
      alqahira
      alwu
      ameihm
      amraj
      amuntner
      Andrew McCreight [:mccr8]
      Andrew Osmond [:aosmond]
      Andrew Sutherland [:asuth]
      Anthony Hughes (:ashughes) [QA]
      antoine.mechelynck
      aosmond
      apdavis
      aphadke
      april
      aravind
      arielb1
      Asa Dotzler [:asa]
      Astley Chen [:astley]
      Away for a while
      b56girard
      baffclan
      bas
      bebe
      Benjamin Smedberg
      bent.mozilla
      bhearsum
      bmo
      bob
      Bobby Holley
      brad
      brandon
      Bruce Sun [:brsun]
      bugmail
      bugs
      bugspam.Callek
      bugzilla
      bugzilla-graveyard
      bwu
      bzhao
      Caglar Ulucenk [:Cag]
      Calixte Denizet (:calixte)
      Cameron McCormack (:heycam)
      Carl Corcoran [:ccorcoran]
      catlee
      cbook
      cchang
      cdenizet
      Cervantes Yu [:cyu] [:cervantes]
      chofmann
      chris
      Chris Hartjes [:grumpy][:chartjes]
      chrisccoulson
      christian
      Chun-Min Chang[:chunmin]
      chutten
      continuation
      cooldipanks14
      coop
      cpeterson
      cshields
      curtisk
      cww
      cyu
      Daniel Thorn [:relud]
      Dave Hunt (:davehunt)
      Dave Townsend [:mossop]
      David Anderson [:dvander]
      David Baron :dbaron:
      David Keeler [:keeler]
      David Major [:dmajor]
      dbolter
      dburns
      dchanm+bugzilla
      dd.mozilla
      David Durst
      deinspanjer
      deletesoftware+moz
      Denis
      dganov
      Dimi Lee[:dimi][:dlee]
      dmaher
      doug.turner
      dteller
      dthorn
      dvander
      dveditz
      ehoogeveen
      ehsan
      Emanuel Hoogeveen [:ehoogeveen]
      Emilio Cobos Álvarez [:emilio]
      Eric Rahm [:erahm]
      erik
      ettseng
      Eva
      ewong
      eziegenhorn
      felash
      Frank Bertsch [:frank]
      fredmessinger
      frgrahl
      gabithume
      Gabriela Thumé
      Gabriele Svelto [:gsvelto]
      gary
      gdestuynder
      Georg Fritzsche [:gfritzsche]
      gerv
      glob
      Greg Guthe [:g-k]
      griswolf
      Guillaume Destuynder [:kang]
      Haik Aftandilian [:haik]
      Hector Zhao [:hectorz]
      Henri Sivonen (:hsivonen)
      hgschutte1
      howareyou322
      htsai
      huseby
      hutusoru.andrei
      info
      J. Ryan Stinnett [:jryans]
      jacob.benoit.1
      James Cheng[:JamesCheng]
      James Teh [:Jamie]
      Jan Alexander Steffens [:heftig]
      Jan Andre Ikenmeyer [:darkspirit]
      Jan Henning [:JanH]
      Jason Orendorff [:jorendorff]
      jaymoz
      jbecerra
      jcoppeard
      jcristau
      jdemooij
      jdm
      jdow
      jduell.mcbugs
      jeads
      Jeff Muizelaar [:jrmuizel]
      Jim Mathies [:jimm]
      jjones
      jmartin
      jmdesp
      jmichae3
      joe
      Johannes Pfrang [:johnp]
      John Lin [:jolin][:jhlin]
      john+bugzilla
      John99-bugs
      jonas
      Jonathan Claudius [:claudijd]
      Jonathan Watt [:jwatt]
      jorgk
      joseph.k.olivas
      josh
      Josh Matthews [:jdm]
      JP Schneider [:jp]
      jrmuizel
      jruderman
      jstenback+bmo
      jteh
      jujjyl
      Julian Seward [:jseward]
      Julien Cristau [:jcristau]
      Justin Wood (:Callek)
      justin.lebar+bug
      jvehent
      JW Wang [:jwwang] [:jw_wang]
      jwalden+bmo
      kairo
      kaku
      kanru
      Kartikaya Gupta
      kchang
      kechen
      Kevin Brosnan [:kbrosnan]
      kiavash.satvat
      Kilik Kuo [:kikuo]
      Krispy2009
      krysztofiak.jedrzej
      Kyle Machulis [:qdot] [:kmachulis]
      lars
      Laura Thomson :laura
      Lehych
      lhenry
      lmandel
      Lonnen :lonnen
      ludovic
      m.goleb+mozilla
      madperson
      Makoto Kato [:m_kato]
      Marcia Knous [:marcia]
      Marco Castelluccio [:marco]
      mark.finkle
      Markus Stange [:mstange]
      martijn.martijn
      mats
      Mats Palmgren (:mats)
      Matt Brandt [:mbrandt]
      mbeltzner
      mcoates
      mdoglio
      mh+mozilla
      mhoye
      Michael Kelly [:mkelly,:Osmose]
      Mieke
      Mike Conley (:mconley)
      milan
      Miles Crabill [:miles]
      Ming-Chou Shih [:stone]
      morgamic
      mounir
      mozilla
      mozilla+bugcloser
      mozillamary
      mozsvcpyup
      mreid
      mstange
      mwu.code
      mzeier
      namachi
      Nathan Froyd [:froydnj]
      Neerja Pancholi[:neerja]
      nelson
      nhirata.bugzilla
      Nicholas Nethercote [:njn]
      nicks.post.kessel
      Nicolas B. Pierron [:nbp]
      nihsanullah
      nitanwar
      nothung
      npancholi
      nthomas
      oremj
      overholt
      ozten.bugs
      Paul Adenot (:padenot)
      Paul Bone [:pbone]
      Peter Bengtsson [:peterbe]
      philipp
      pulgasaur
      pulsebot
      pyup-bot
      Rail Aliiev [:rail]
      Raja Uzair Abdullah
      Randell Jesup [:jesup]
      rbryce
      reed
      release-mgmt-account-bot
      renovate[bot]
      rkothari
      rmcguigan
      rob
      Rob Wu [:robwu]
      rob1weld
      Robert Helmer [:rhelmer]
      robert.chira
      robert.strong.bugs
      rpappalardo
      Ryan VanderMeulen [:RyanVM]
      ryansnyder.me+bugs
      Salvador Espinoza [:sal]
      samuel.sidler+old
      sbennetts
      scabral
      schalk.neethling.bugs
      scoobidiver
      sdeckelmann
      sespinoza
      shaver
      Shawn Huang [:shawnjohnjr]
      shuang
      skywalker333
      smani
      smooney
      sphink
      spohl.mozilla.bugs
      sshih
      standard8
      Stephen A Pohl [:spohl]
      Stephen Donner [:stephend]
      stevedocherty97
      Susingh
      swu
      Sylvestre Ledru [:sylvestre]
      Ted Campbell [:tcampbell]
      Ted Mielczarek [:ted.mielczarek]
      Thomas Nguyen[:tnguyen]
      thuelbert
      timeless
      Tobias B. Besemer [:BesTo] (QA)
      trevor
      trifandreialin
      Tzuhao Kuo [:kaku]
      Vance Chen [:vchen]
      Vincent Liu[:vliu]
      Virtual_ManPL [:Virtual]
      vladan.bugzilla
      vm
      vps.pacitan
      Wayne Mery (:wsmwk)
      wcosta
      wildmyron
      Will Kahn-Greene [:willkg]
      wmccloskey
      xstevens
      yfdyh000
      yuhongbao_386
      zackw
      zolenkoe
      zxspectrum3579
