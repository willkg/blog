.. title: Socorro Engineering: Year in Review 2019
.. slug: socorro_2019
.. date: 2020-01-06 10:00
.. tags: mozilla, work, socorro, tecken, buildhub, pollbot, mls

Summary
=======

Last year at about this time, I wrote a year in review blog post. Since I only
worked on Socorro at the time, it was all about Socorro. In 2019, that changed,
so this blog post covers the efforts of two people across a bunch of projects.

2019 was pretty nuts. We accomplished a lot, but picking up a bunch of new
projects really threw a wrench in the wheel of ongoing work.

This year in review covers highlights, some numbers, and some things I took
away.

Here's the list of projects we worked on over the year:

* `Crash stats <https://crash-stats.mozilla.org/>`_: (aka Socorro) the Mozilla
  crash ingestion pipeline
* `Symbols server <https://symbols.mozilla.org/>`_: (aka Tecken) the Mozilla
  symbols server
* `Buildhub <https://github.com/mozilla-services/buildhub/>`_ and
  `Buildhub2 <https://buildhub.moz.tools/>`_: indexes of builds of Mozilla
  products
* `PollBot <https://github.com/mozilla/pollbot/>`_ and
  `Delivery Dashboard <https://mozilla.github.io/delivery-dashboard/>`_: a
  system for showing release status
* `Mozilla Location Services <https://location.services.mozilla.com/>`_:
  Mozilla's geolocation system


.. TEASER_END

Highlights 2019
===============

While there are good reasons for why 2019 was nuts, it was soooo nuts. Some
highlights:

* **I released Everett v1.0.0.**

  `Everett <https://everett.readthedocs.io/>`_ is a Python library for managing
  configuration. It's similar to other libraries, but it includes support for
  documenting configuration and testing with configuration which makes
  development and using projects that use Everett a lot easier.

  :doc:`I released version 1.0.0 in January <everett_1_0_0>`.

* **I reimplemented crontabber in Socorro.**

  Socorro has a scheduled tasks system and relied on a library called
  `crontabber <https://crontabber.readthedocs.io/>`_. crontabber was initially
  part of Socorro and was extracted so other people could use it.

  The crontabber code wasn't well maintained and it had a lot of issues. I
  decided it was easier and more convenient to rewrite it as Django management
  commands than to take on maintaining the crontabber library. So I did.

* **I stepped down as the Bleach maintainer.**

  `Bleach <https://bleach.readthedocs.io/>`_ is a Python library that makes
  user-provided content safe in an HTML context. It's used in a lot of places.
  It's slow, it's a difficult and complex problem domain, it's finicky and
  fragile, and it relies on another library called html5lib which has its own
  set of daunting problems.
  
  In March, I stepped down because I was burned out and needed to reduce the
  number of things I was working on out of sheer obligation.
  
  Months after I put it down, I still feel lousy that I walked away. Every time
  I think about how I feel lousy, I tell myself it was the right thing to do.

  :doc:`I talk about stepping down from Bleach <bleach_stepping_down>`.

* **I migrated Socorro from RabbitMQ to Google Pub/Sub.**

  I redid how Socorro handles queuing crash reports for processing.
  Previously, it used RabbitMQ. I switched it to Google Pub/Sub. In doing this,
  I removed one of the components between the collector and the processor which
  was sometimes flaky, so that was good. This was the first step in moving all
  of Socorro to Google Cloud Platform.

  Later in the year, we decided not to move Socorro to Google Cloud Platform.
  Fun times!

* **I got a new co-worker!**

  I was working with Osmose for parts of 2018, but he left in early 2019 and
  even when he was around, he was on other projects and I was mostly working on
  my own and increasingly feeling disconnected and isolated. That kind of
  sucked.
  
  In April-ish, John joined me on Socorro. John's great to work with! Not only
  does he reduce the bus factor for our projects, allow me to go on vacations
  with less anxiety, and have a predilection towards deep dives into mysterious
  problems, but he's also wonderful to talk with. Yay for co-workers!

* **We took over and audited Buildhub.**
  
  In April-ish, John and I inherited Buildhub. It was written a couple of years
  prior to be an index of build information for Mozilla projects. The build
  process creates artifacts on archive.mozilla.org which is an AWS S3 bucket
  with a web interface of the directory structure. Buildhub consumes that
  information, puts it into an index, and provides a search interface for it.

  Socorro needs this information for converting (buildid, channel, version) to
  a proper version string. Mission Control needs this information for similar
  things. There are other systems that use it, too.
  
  John and I audited the Buildhub project. We wrote up a bunch of issues for
  things that surfaced from the audit. We fixed security issues and performed
  some necessary maintenance.

* **We took over and audited Buildhub2.**

  The way Buildhub was built, it was really challenging to debug problems with
  build artifact ingestion. It had a lot of problems with missing information
  for unclear reasons.

  Buildhub2 was another attempt at building a build information index. It was
  launched at the end of 2018. It took a different approach and was a stricter
  mirror of the information on archive.mozilla.org--it didn't attempt to infer
  anything from older builds which didn't have ``buildhub.json`` files.

  We audited the Buildhub2 project, wrote up a bunch of issues that surfaced
  from the audit, fixed security issues, updated dependencies, rewrote the
  documentation, and wrote a basic runbook.

* **We shut down Buildhub.**

  During the Buildhub and Buildhub2 audits, I decided that while Buildhub2 has
  a different set of issues with its data, it was better than maintaining two
  indexes. I wrote up a plan to shut down Buildhub, identified and fixed
  blocking issues in Buildhub2, and migrated projects from Buildhub to
  Buildhub2.

  Then we shut down and dismantled Buildhub.

* **We took over PollBot and Dependency Dashboard.**

  "Took over" is a bit of a stretch here. We did a rough audit of both projects
  and fixed some security issues with dependencies. However, we didn't get very
  far in absorbing either of these and still don't know much about them.

* **We took over and audited Tecken.**

  Tecken is the Mozilla Symbols Server. It's used by a bunch of projects 
  including Socorro for symbolicating stacks.

  Tecken was in pretty good shape, so we haven't had to spend a lot of time on
  urgent work.

* **I wrote an essay on crash pings (Telemetry) vs crash reports (Socorro/Crash Stats).**

  In July, I wrote :doc:`Crash pings (Telemetry) and crash reports
  (Socorro/Crash Stats) <crash_pings_crash_reports>`. It took a while to
  write because it goes into a lot of detail for specific things. I know there
  have been changes in Telemetry-land as they moved to GCP, so I bet parts of it
  are wrong now. Writing it sure helped me and other people understand the
  current situation regarding crash report data and which data is good to use
  for what purposes.

  Will Lachance and I bandied about writing a more permanent manual for crash
  report data. I think that's a good idea, but I had to switch projects and
  haven't had time to spend on it, yet.

  I want to go through the essay and do an update at some point soon.

* **I released crashstats-tools v1.0.1.**

  In 2018, I was tinkering with `crashstats-tools
  <https://github.com/willkg/crashstats-tools>`_. as a standalone set of
  command line tools that make it easier to manipulate crash report data from
  Crash Stats using the Crash Stats APIs in a command-line context.
  
  I use these tools in a few different ways mostly when looking into issues
  with Socorro processing. I wasn't sure if anyone else would use it, so I
  didn't tell anyone for a while--I didn't want to add another project to my
  plate that required ongoing maintenance work.

  In 2019, Gabriele and Marco spent a lot of time improving the situation
  around system library symbols. Up until recently, we had system library
  symbols for Windows in some cases and some for some versions of Mac OS, but
  parts of it were really manual and we didn't have a good story for Linux and
  it was generally just not great. This is a problem when walking and
  symbolicating stacks. Without symbols, the stackwalker has to guess where the
  frames are and that's problematic. Further, the result isn't human readable.
  For example, you end up with stuff like this::

    0 	libxul.so 	libxul.so@0x43d015b 		context
    1 	libxul.so 	libxul.so@0x43cffb6 		frame_pointer
    2 	libxul.so 	libxul.so@0x415bc0e 		frame_pointer
    3 	libxul.so 	libxul.so@0x3f6c4f8 		scan
    4 	libxul.so 	libxul.so@0x3fe0e4b 		scan
    5 	libxul.so 	libxul.so@0x3fde1bd 		scan
    6 	libxul.so 	libxul.so@0x3fde9cf 		scan
    7 	libxul.so 	libxul.so@0x3fd07f8 		scan
    8 	libxul.so 	libxul.so@0x553c1df 		scan
    9 	libxul.so 	libxul.so@0x3fd088f 		scan
    10 	libxul.so 	libxul.so@0x553c1df 		scan
    11 	libxul.so 	libxul.so@0x3fd1bc0 		scan
    12 	libxul.so 	libxul.so@0x3fea0a8 		scan
    13 	libxul.so 	libxul.so@0x3feac6f 		scan
    14 	libxul.so 	libxul.so@0x3ff276c 		scan
    15 	libxul.so 	libxul.so@0x3feadda 		scan
    16 	libxul.so 	libxul.so@0x3fd6f7b 		scan
    17 	libxul.so 	libxul.so@0x3fec0a3 		scan


  After Gabriele and Marco's work, we now have this::

    0 	libxul.so 	<hashglobe::hash_map::HashMap<K, V, S>>::clear 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/servo/components/hashglobe/src/hash_map.rs:1050 	context
    1 	libxul.so 	style::stylist::CascadeData::clear 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/servo/components/style/stylist.rs:2412 	cfi
    2 	libxul.so 	Servo_StyleSet_FlushStyleSheets 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/servo/components/style/stylist.rs:2048 	cfi
    3 	libxul.so 	mozilla::ServoStyleSet::UpdateStylist() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/layout/style/ServoStyleSet.cpp:1374 	cfi
    4 	libxul.so 	mozilla::ServoStyleSet::ResolveInheritingAnonymousBoxStyle(nsAtom*, mozilla::ServoStyleContext*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/layout/style/ServoStyleSet.cpp:592 	cfi
    5 	libxul.so 	nsCSSFrameConstructor::ConstructRootFrame() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/layout/base/nsCSSFrameConstructor.cpp:2661 	cfi
    6 	libxul.so 	mozilla::PresShell::Initialize() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/layout/base/PresShell.cpp:1685 	cfi
    7 	libxul.so 	nsContentSink::StartLayout(bool) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/dom/base/nsContentSink.cpp:1203 	cfi
    8 	libxul.so 	nsHtml5TreeOpExecutor::StartLayout(bool*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/parser/html/nsHtml5TreeOpExecutor.cpp:639 	cfi
    9 	libxul.so 	nsHtml5TreeOperation::Perform(nsHtml5TreeOpExecutor*, nsIContent**, bool*, bool*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/parser/html/nsHtml5TreeOperation.cpp:1110 	cfi
    10 	libxul.so 	nsHtml5TreeOpExecutor::RunFlushLoop() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/parser/html/nsHtml5TreeOpExecutor.cpp:456 	cfi
    11 	libxul.so 	nsHtml5ExecutorFlusher::Run() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/parser/html/nsHtml5StreamParser.cpp:125 	cfi
    12 	libxul.so 	mozilla::SchedulerGroup::Runnable::Run() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/xpcom/threads/SchedulerGroup.cpp:370 	cfi
    13 	libxul.so 	nsThread::ProcessNextEvent(bool, bool*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/xpcom/threads/nsThread.cpp:975 	cfi
    14 	libxul.so 	NS_ProcessNextEvent(nsIThread*, bool) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/xpcom/threads/nsThreadUtils.cpp:455 	cfi
    15 	libxul.so 	mozilla::ipc::MessagePump::Run(base::MessagePump::Delegate*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/ipc/glue/MessagePump.cpp:88 	cfi
    16 	libxul.so 	MessageLoop::Run() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/ipc/chromium/src/base/message_loop.cc:290 	cfi
    17 	libxul.so 	nsBaseAppShell::Run() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/widget/nsBaseAppShell.cpp:136 	cfi
    18 	libxul.so 	XRE_RunAppShell() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/toolkit/xre/nsEmbedFunctions.cpp:860 	cfi
    19 	libxul.so 	MessageLoop::Run() 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/ipc/chromium/src/base/message_loop.cc:290 	cfi
    20 	libxul.so 	XRE_InitChildProcess(int, char**, XREChildData const*) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/toolkit/xre/nsEmbedFunctions.cpp:698 	cfi
    21 	firefox-esr 	content_process_main(mozilla::Bootstrap*, int, char**) 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/browser/app/../../ipc/contentproc/plugin-container.cpp:49 	cfi
    22 	firefox-esr 	main 	/build/firefox-esr-Mag8OK/firefox-esr-60.7.1esr/browser/app/nsBrowserApp.cpp:254 	cfi
    Ø 23 	libc-2.24.so 	libc-2.24.so@0x202e0 		cfi
    24 	firefox-esr 	firefox-esr@0x561f 		scan
    25 	firefox-esr 	firefox-esr@0x596f 		scan
    Ø 26 	ld-2.24.so 	ld-2.24.so@0xf96a 		scan
    27 	firefox-esr 	firefox-esr@0x596f 		scan
    28 	firefox-esr 	_start 		scan
    29 		@0x7ffe1c04eb37

  Big difference, right?!

  Gabriele told me he's using crashstats-tools in their symbols upload scripts.
  So the scripts upload symbols for modules that are missing in Mozilla Symbols
  server, then do a search on Crash Stats for crash reports where those modules
  show up in the stack, and reprocess those crash reports. That's immensely
  helpful.

  :doc:`I wrote about the crashstats-tools release. <crashstats_tools_v1_0_1>`

* **John and I picked up Mozilla Location Services.**

  Mozilla Location Services had been dormant for years. It was running Python
  2.6 on Scientific Linux. It had a deploy pipeline that was several
  generations old. It was in an unmaintainable state.

  John, me, and our ops person ckolos overhauled the project, finished up the
  Docker-ization of the services, finished the mostly-done migration from
  Python 2.6 to Python 3, updated dependencies, reduced a bunch of complexity,
  wrote a lot of documentation, fixed a ton of issues, pushed out a new deploy
  pipeline and Docker-based infrastructure, and did a series of stop-gap fixes
  for processing.
  
  It was a massive undertaking. The infrastructure migration went smoothly--the
  site was unavailable for like 15 minutes during the switch over from the old
  infrastructure and old code base to the new one.

  There are still a bunch of issues with the system. We're triaging them now.
  However, it's maintainable and we can do deploys so it's vastly improved
  situation.

  This is currently our primary project, so we'll be spending most of our time
  on this in early 2019.

* **We passed off some projects.**

  After picking up Mozilla Location Services, John and I were spread waaaay too
  thin, so we passed off Buildhub2 and PollBot to the build engineering team.
  That was a little tricky because I had only had these projects for a short
  period of time, so it was hard to answer questions about them.

* **I released Markus v2.0.0.**

  `Markus <https://markus.readthedocs.io/>`_ is a Python library for metrics
  generation. It wraps statsd and dogstatsd and some other libraries and makes
  it much easier to develop and test code that generates metrics. I use it in
  all my projects.

  Version 2.0.0 involved a minor rewrite to support filters. Filters let you
  adjust metrics before they get emitted. This makes it easier to add tags to
  all metrics generated for a service with things like the host and service
  type.

  :doc:`I wrote about Markus v2.0.0 here. <markus_2_0_0>`

* **I redid the queueing code in Socorro to use AWS SQS.**

  Since I switched Socorro to use Google Pub/Sub for queuing crash reports to
  process, Socorro has been split across two cloud platforms. That's kind of
  annoying. Since Socorro was staying in AWS, I decided to switch it to use AWS
  SQS.

  That turned out to be a lot harder than I thought it would be because I had
  to fix a bunch of technical debt around boto -> boto3.

  I managed to get all the code changes done. We'll probably migrate from
  Google Pub/Sub to AWS SQS in 2019q1.


That's the highlights of 2019. While I think we accomplished a lot, it's
frustrating because there were so many things I wanted to do in 2019, but just
couldn't find time or energy for. For example, we still have a bunch of
technical debt in Socorro that I want to get through. It's good to have a team
of more-than-one. I feel a little less anxious to go on vacation.

2020 will have us focusing on Mozilla Location Services with Socorro and Tecken
in maintenance mode.


Thank you!
==========

Thank you to Gabriele and Marco for their work on getting systems library
symbols and working with us to improve Socorro and Tecken. I look forward to
the efforts on Rust-ifying everything. That'll help a lot!

Thank you to Stephen Michaud who spent a ton of time improving crash reporting
and analysis on Mac OS x86_64h (I think that's what it was)! Keeping up with
him was tough because there were so many other things going on, but he did
awesome work!

Thank you to everyone who submitted signature generation fixes in Socorro!

Thank you to Liz and Marcia who are very patient with me!

Thank you to everyone who submitted bugs and pull requests and helped in other
ways!

Thank you to Brian and Miles for Socorro and Tecken ops! Thank you ckolos for
MLS ops!

Thank you to Lonnen and Laura for helping us survive 2019!


Summarized Bugzilla and GitHub stats for 2019
==============================================

We've got so many projects now and we did so much work, the output of my review
script is nuts, so this is a summary of the bits I think are interesting.

::

    Period (2019-01-01 -> 2019-12-31)
    =================================
    
    Bugzilla
    ========
    
      Bugs created: 457
      Creators: 101
      Top 10 count-wise: 

           Will Kahn-Greene [:willkg] ET  : 236
               John Whitlock [:jwhitlock] : 22
           Steven Michaud [:smichaud] (Re : 21
               Gabriele Svelto [:gsvelto] : 16
                              Brian Pitts : 16
           Marcia Knous [:marcia - needin : 14
           Kartikaya Gupta (email:kats@mo : 5
               Jeff Muizelaar [:jrmuizel] : 4
                     Liz Henry (:lizzard) : 4
                Andrew McCreight [:mccr8] : 4

    
      Bugs resolved: 462
    
                                  INVALID : 14
                                    FIXED : 384
                               INCOMPLETE : 5
                                  WONTFIX : 36
                               WORKSFORME : 11
                                DUPLICATE : 6
                                          : 1
                                 INACTIVE : 5
    
      Resolvers: 32
      Top 10 count-wise:
    
           Will Kahn-Greene [:willkg] ET  : 332
               John Whitlock [:jwhitlock] : 66
                              Brian Pitts : 16
                Osmose [:osmose, :mkelly] : 6
           Marco Castelluccio [:marco] (P : 6
           Miles Crabill [:miles] [also m : 6
                Andrew McCreight [:mccr8] : 5
               Peter Bengtsson [:peterbe] : 4
                      mozillamarcia.knous : 3
                             chris.lonnen : 1

      Commenters: 161
      Top 10 count-wise:
    
                                   willkg : 1681
                                jwhitlock : 200
                                 smichaud : 78
                                  peterbe : 61
                                  gsvelto : 52
                      mozillamarcia.knous : 46
                        mozilla+bugcloser : 40
                                   bpitts : 40
                            mcastelluccio : 36
                                       me : 31
    
      Statistics
    
          Youngest bug : 0.0d: 1517290: socorro: deploy 358
       Average bug age : 148.2d
        Median bug age : 5.0d
            Oldest bug : 3383.0d: 539370: Missing symbols for GTK system libraries, libgt...
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 307
        Committers:
                   willkg :   230  (+37601, -39109,  653 files)
                jwhitlock :    39  ( +2140,  -1399,  106 files)
            rvandermeulen :     9  (    +9,     -9,    1 files)
                   Osmose :     7  (  +315,   -250,   26 files)
                 pyup-bot :     5  (  +586,   -565,   33 files)
          dependabot[bot] :     3  (   +28,    -20,    2 files)
                 jrmuizel :     3  (    +4,     -0,    1 files)
               amccreight :     2  (    +3,     -3,    2 files)
                  lizzard :     1  (    +1,     -1,    1 files)
                 jcristau :     1  (    +1,     -1,    1 files)
                 glandium :     1  (    +1,     -0,    1 files)
                   emilio :     1  (    +2,     -2,    1 files)
                bobbyg603 :     1  (    +1,     -1,    1 files)
             philipp-sumo :     1  (    +2,     -0,    2 files)
                staktrace :     1  (    +1,     -0,    1 files)
                  peterbe :     1  (    +1,     -1,    1 files)
                  froydnj :     1  (    +2,     -2,    1 files)
    
                    Total :        (+40698, -41363,  664 files)
    
        Most changed files:
          requirements/default.txt (33)
          webapp-django/crashstats/settings/base.py (31)
          socorro/signature/siglists/prefix_signature_re.txt (31)
          webapp-django/crashstats/crashstats/models.py (25)
          requirements/constraints.txt (22)
          socorro/external/es/super_search_fields.py (19)
          webapp-django/crashstats/api/tests/test_views.py (14)
          webapp-django/crashstats/crashstats/tests/test_views.py (14)
          docker/config/local_dev.env (14)
          webapp-django/crashstats/crashstats/admin.py (14)
    
        Age stats:
              Youngest PR : 0.0d: 5076: bug 1597730: remove quit check
           Average PR age : 0.5d
            Median PR age : 0.0d
                Oldest PR : 27.0d: 4931: bug 1545446: Remove Fira-Sans, reduce font list
    
      mozilla-services/antenna:
    
        Merged PRs: 56
        Committers:
                   willkg :    54  ( +5811,  -3992,   79 files)
                 pyup-bot :     2  (   +36,    -36,    1 files)
    
                    Total :        ( +5847,  -4028,   79 files)
    
        Most changed files:
          requirements/default.txt (19)
          requirements/constraints.txt (12)
          antenna/breakpad_resource.py (11)
          antenna/ext/s3/connection.py (7)
          tests/unittest/conftest.py (7)
          antenna/ext/pubsub/crashpublish.py (7)
          docker/Dockerfile (6)
          antenna/app.py (6)
          docker/config/local_dev.env (5)
          docker/run_tests_in_docker.sh (5)
    
        Age stats:
              Youngest PR : 0.0d: 373: bug 1601455: add AWS SQS crashpublish support
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 1.0d: 299: fix bug 1527343: implement publishing to Pub/Sub
    
      mozilla-services/tecken:

        Closed issues: 2
        Merged PRs: 62
        Committers:
            renovate[bot] :    25  (  +448,   -502,    6 files)
                 pyup-bot :    21  (  +272,   -257,    4 files)
                   willkg :    12  ( +2705,  -3557,   16 files)
                jwhitlock :     4  ( +2246,  -3466,   26 files)
    
                    Total :        ( +5671,  -7782,   35 files)
    
        Most changed files:
          requirements.txt (25)
          frontend/package.json (20)
          frontend/yarn.lock (20)
          Dockerfile (9)
          frontend/Dockerfile (4)
          requirements-constraints.txt (3)
          docs-requirements.txt (3)
          docs/dev.rst (3)
          tecken/settings.py (2)
          tecken/api/views.py (2)
    
        Age stats:
              Youngest PR : 0.0d: 1908: Update handlerbars to 4.5.3
           Average PR age : 1.6d
            Median PR age : 0.0d
                Oldest PR : 9.0d: 1903: Update react monorepo to v16.12.0
    
      mozilla/ichnaea:

        Closed issues: 79
                                   willkg : 29
                                jwhitlock : 21
                                   ckolos : 1
    
        Merged PRs: 106
        Committers:
                jwhitlock :    55  (+10755,  -6313,  121 files)
                   willkg :    43  (+14501, -12999,  239 files)
          dependabot[bot] :     2  (    +6,     -6,    1 files)
                 pyup-bot :     2  (  +222,   -212,    2 files)
                  rindeal :     1  (    +5,     -5,    1 files)
          Mozilla-GitHub- :     1  (   +15,     -0,    1 files)
                   ckolos :     1  (    +7,     -1,    1 files)
                   lonnen :     1  (  +275,    -32,   12 files)
    
                    Total :        (+25786, -19568,  285 files)
    
        Most changed files:
          requirements/default.txt (31)
          requirements/constraints.txt (24)
          ichnaea/conf.py (12)
          ichnaea/db.py (11)
          ichnaea/conftest.py (11)
          ichnaea/log.py (11)
          ichnaea/webapp/tests.py (8)
          ichnaea/taskapp/config.py (7)
          .circleci/config.yml (7)
          ichnaea/content/tests/test_views.py (7)
    
        Age stats:
              Youngest PR : 0.0d: 1017: Bump waitress from 1.3.1 to 1.4.0 in /requirements
           Average PR age : 6.0d
            Median PR age : 0.0d
                Oldest PR : 411.0d: 522: fix line separator issues in public csv exporter
    
    
      All repositories:
    
        Total closed issues: 81
        Total merged PRs: 531
