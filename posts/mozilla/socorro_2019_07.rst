.. title: Socorro Engineering: July 2019 happenings and putting it on hold
.. slug: socorro_2019_07
.. date: 2019-08-06 06:00
.. tags: mozilla, work, socorro, tecken, buildhub

Summary
=======

Socorro Engineering team covers several projects:

* `Socorro <https://github.com/mozilla-services/socorro>`_ is the crash
  ingestion pipeline and `Crash Stats web service
  <https://crash-stats.mozilla.org>`_ for Mozilla's products like Firefox.
* `Tecken <https://github.com/mozilla-services/tecken>`_ is the `symbols server
  <https://symbols.mozilla.org/>`_ for uploading, downloading, and
  symbolicating stacks.
* `Buildhub2 <https://github.com/mozilla-services/buildhub2>`_ is the 
  `build information index <https://buildhub.moz.tools/>`_.
* Buildhub is the previous iteration of Buildhub2 that's currently
  deprecated and will get decommissioned soon.
* PollBot and Delivery Dashboard are something something.

This blog post summarizes our activities in July.


Highlights of July
==================

* Socorro: Added ``modules_in_stack`` field to super search allowing people to
  search the set of module/debugid for functions that are in teh stack of the
  crashing thread.

  This lets us reprocess crash reports that have modules for which symbols
  were just uploaded.

* Socorro: Added PHC related fields, ``dom_fission_enabled``, and
  ``bug_1541161`` to super search.

* Socorro: Fixed some things further streamlining the local dev environment.

* Socorro: Reformatted Python code with Black.

* Socorro: Extracted ``supersearch`` and ``fetch-data`` commands as a separate
  Python library: https://github.com/willkg/crashstats-tools

* Tecken: Upgraded to Python 3.7 and adjusted storage bucket code to work
  better for multiple storage providers.

* Tecken: Added GCS emulator for local development environment.

* PollBot: Updated to use Buildhub2.


Hiatus and project changes
==========================

In April, we picked up Tecken, Buildhub, Buildhub2, and PollBot in addition to
working on Socorro. Since then, we've:

* audited Tecken, Buildhub, Buildhub2, and PollBot
* updated all projects, updated dependencies, and performed other necessary
  maintenance
* documented deploy procedures and basic runbooks
* deprecated Buildhub in favor of Buildhub2 and updated projects to use
  Buildhub2

Buildhub is decommissioned now and is being dismantled.

We're passing Buildhub2 and PollBot off to another team. They'll take ownership
of those projects going forward.

Socorro and Tecken are switching to maintenance mode as of last week. All
Socorro/Tecken related projects are on hold. We'll continue to maintain the two
sites doing "keep the lights on" type things:

* granting access to memory dumps
* adding new products
* adding fields to super search
* making changes to signature generation and updating siggen library
* responding to outages
* fixing security issues

All other non-urgent work will be pushed off.

As of August 1st, we've switched to Mozilla Location Services. We'll be
auditing that project, getting it back into a healthy state, and bringing it in
line with current standards and practices.

Given that, this is the last Socorro Engineering status post for a while.


.. TEASER_END

Bugzilla and GitHub stats for July
==================================

::

    Period (2019-07-01 -> 2019-07-31)
    =================================
    
    
    Bugzilla
    ========
    
      Bugs created: 32
      Creators: 13
    
           Will Kahn-Greene [:willkg] ET  : 13
               John Whitlock [:jwhitlock] : 7
                              Brian Pitts : 2
                               [:philipp] : 1
                Andrew McCreight [:mccr8] : 1
           Cristian Comorasu, QA [:ccomor : 1
           Maria Berlinger [:maria_berlin : 1
                                  Fox one : 1
               Nicholas Nethercote [:njn] : 1
              Christian Holler (:decoder) : 1
                   Nicolas Silva [:nical] : 1
                 Brindusa Tot[:brindusat] : 1
           Christoph Kerschbaumer [:ckers : 1
    
      Bugs resolved: 46
    
                                  WONTFIX : 1
                                          : 1
                                    FIXED : 42
                                DUPLICATE : 1
                                  INVALID : 1
    
      Resolvers: 5
    
           Will Kahn-Greene [:willkg] ET  : 24
               John Whitlock [:jwhitlock] : 19
                      mozillamarcia.knous : 2
                              Brian Pitts : 1
    
      Commenters: 42
    
                                   willkg : 139
                                jwhitlock : 59
                      mozillamarcia.knous : 20
                                   tmaity : 11
                            mcastelluccio : 7
                                 vseerror : 4
                                   bpitts : 3
                        mozilla+bugcloser : 3
                       spohl.mozilla.bugs : 3
                             continuation : 3
                             n.nethercote : 3
                                 ckerschb : 3
                                       me : 2
                               mh+mozilla : 2
                             haftandilian : 2
                              jdragojevic : 2
                             cornel.ionce : 2
                           cristian.baica : 2
                            timea.zsoldos : 2
                            camelia.badau : 2
                             daniel.cicas : 2
                                 jgilbert : 2
                               jbonisteel : 2
                        cristian.comorasu : 2
                          maria.berlinger : 2
                                 hosselot : 2
                                  choller : 2
                           nical.bugzilla : 2
                             brindusa.tot : 2
                                   yoasif : 1
                                  gsvelto : 1
                             chris.lonnen : 1
                                   adrian : 1
                          ciprian.georgiu : 1
                           cristian.fogel : 1
                              vlad.lucaci : 1
                             oana.botisan : 1
                                madperson : 1
                               tgrabowski : 1
                                   ajones : 1
                                abillings : 1
                                  dveditz : 1
    
      Tracker bugs: 0
    
    
      Statistics
    
          Youngest bug : 0.0d: 1563172: First release candidate build for Firefox 68 is...
       Average bug age : 36.3d
        Median bug age : 13.0d
            Oldest bug : 387.0d: 1473068: Periodic "An Unexpected Error Occurred" when br...
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 23
    
        * 4997: bug 1569582: add Bug_1541161 annotation to super search (willkg)
        * 4996: bug 1559223, 1542964: add modules_in_stack to processed crash (willkg)
        * 4995: bug 1503344: start putting data in java_stack_trace_raw (willkg)
        * 4991: bug 1563222: add createuser script to oidcprovider container (willkg)
        * 4992: bug 1563222: Drop confirmation of OIDC provider (jwhitlock)
        * 4994: Update release.py (willkg)
        * 4993: Fix fetch_crash_data to optionally not download raw crash data (willkg)
        * 4990: bug 1563230: wrap cronrun in a timeout (willkg)
        * 4989: bug 1523278: add PHC field processing and searchability (willkg)
        * 4988: bug 1567990: add scaffolding for running black and reformat python code (willkg)
        * 4987: bug 1563317: add DOMFissionEnabled to search (willkg)
        * 4986: bug 1564551: Expand and test is_valid_model_class (jwhitlock)
        * 4982: bug 1564551: Validation error for null characters, plus API view updates (jwhitlock)
        * 4984: bug 1552709: Escape surrogates on report index (jwhitlock)
        * 4985: bug 1567528: Filter MozCrashReason with eval msg (jwhitlock)
        * 4981: Bump lodash from 4.17.11 to 4.17.14 in /webapp-django (dependabot[bot])
        * 4980: Update current Fennec Nightly & Beta version numbers (rvandermeulen)
        * 4977: bug 1562665: Use nip.io to avoid /etc/hosts change (jwhitlock)
        * 4979: Update Fennec release version to 68.0 (jcristau)
        * 4978: bug 1563261: fix /monitoring/heartbeat/ Elasticsearch connection (willkg)
        * 4975: bug 1561628: change deploy process (willkg)
        * 4976: Monthly update for July (jwhitlock)
        * 4970: Update awscli, botocore, select requirements (jwhitlock)
    
        Committers:
                   willkg :    12  (+18427, -18473,  277 files)
                jwhitlock :     8  (  +358,   -376,   16 files)
          dependabot[bot] :     1  (   +22,    -14,    1 files)
            rvandermeulen :     1  (    +1,     -1,    1 files)
                 jcristau :     1  (    +1,     -1,    1 files)
    
                    Total :        (+18809, -18865,  283 files)
    
        Most changed files:
          socorro/external/es/super_search_fields.py (6)
          socorro/processor/rules/mozilla.py (5)
          socorro/unittest/processor/rules/test_mozilla.py (5)
          socorro/processor/processor_pipeline.py (4)
          scripts/release.py (3)
          requirements/constraints.txt (3)
          requirements/default.txt (3)
          webapp-django/crashstats/api/tests/test_views.py (3)
          webapp-django/crashstats/api/views.py (3)
          webapp-django/crashstats/crashstats/jinja2/crashstats/report_index.html (2)
    
        Age stats:
              Youngest PR : 0.0d: 4997: bug 1569582: add Bug_1541161 annotation to supe...
           Average PR age : 1.5d
            Median PR age : 0.0d
                Oldest PR : 10.0d: 4982: bug 1564551: Validation error for null characte...
    
      mozilla-services/antenna:
    
        Merged PRs: 6
    
        * 356: Update release.py (willkg)
        * 355: Fix line length to 88 (willkg)
        * 354: bug 1557706: fix systemtests to work with discarded reasons (willkg)
        * 353: bug 1560983: add black scaffolding and reformat the code (willkg)
        * 352: Update pytest and bandit to current versions (willkg)
        * 351: bug 1561628: add bin/release.py script (willkg)
    
        Committers:
                   willkg :     6  ( +1762,  -1694,   45 files)
    
                    Total :        ( +1762,  -1694,   45 files)
    
        Most changed files:
          bin/release.py (3)
          setup.cfg (2)
          antenna/breakpad_resource.py (2)
          tests/systemtest/test_content_length.py (2)
          tests/systemtest/test_discards.py (2)
          requirements/default.txt (2)
          Makefile (1)
          antenna/__init__.py (1)
          antenna/app.py (1)
          antenna/ext/crashpublish_base.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 356: Update release.py
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 356: Update release.py
    
      mozilla-services/tecken:
    
        Merged PRs: 9
    
        * 1843: Upgrade js dependencies (willkg)
        * 1842: Upgrade to Python 3.7 (willkg)
        * 1837: Update node:10.16.0-slim Docker digest to 3af9a90 (renovate[bot])
        * 1841: Update Python requirements and constraints (willkg)
        * 1840: Update vulnerable js dependencies (willkg)
        * 1839: bug 1564452: Add StorageBucket.exists(), .backend() (jwhitlock)
        * 1827: Update python:3.6-slim Docker digest to c680e3c (renovate[bot])
        * 1830: bug 1552950: Add GCS Emulator (jwhitlock)
        * 1836: Scheduled monthly dependency update for July (pyup-bot)
    
        Committers:
                   willkg :     4  ( +2729,  -2288,    7 files)
            renovate[bot] :     2  (    +3,     -3,    2 files)
                jwhitlock :     2  (  +756,   -332,   13 files)
                 pyup-bot :     1  (   +46,    -46,    2 files)
    
                    Total :        ( +3534,  -2669,   22 files)
    
        Most changed files:
          Dockerfile (3)
          frontend/package.json (2)
          frontend/yarn.lock (2)
          requirements.txt (2)
          tecken/apps.py (2)
          tecken/download/views.py (2)
          tecken/storage.py (2)
          tests/test_dockerflow_extra.py (2)
          tests/test_storage.py (2)
          tests/test_upload.py (2)
    
        Age stats:
              Youngest PR : 0.0d: 1843: Upgrade js dependencies
           Average PR age : 10.0d
            Median PR age : 0.0d
                Oldest PR : 36.0d: 1827: Update python:3.6-slim Docker digest to c680e3c
    
      mozilla-services/buildhub2:
        Closed issues: 7
    
        Merged PRs: 2
    
        * 599: Update vulnerable js dependencies (willkg)
        * 598: Update vulnerable js dependencies (willkg)
    
        Committers:
                   willkg :     2  (  +698,   -308,    2 files)
    
                    Total :        (  +698,   -308,    2 files)
    
        Most changed files:
          ui/package.json (2)
          ui/yarn.lock (2)
    
        Age stats:
              Youngest PR : 0.0d: 599: Update vulnerable js dependencies
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 599: Update vulnerable js dependencies
    
      mozilla-services/buildhub:
    
      mozilla/PollBot:
        Closed issues: 1
    
        Merged PRs: 3
    
        * 250: Update to use Buildhub2 (willkg)
        * 251: Fix "make run" (willkg)
        * 249: Update Jinja2 (willkg)
    
        Committers:
                   willkg :     3  (   +26,    -33,    5 files)
    
                    Total :        (   +26,    -33,    5 files)
    
        Most changed files:
          pollbot/tasks/buildhub.py (1)
          tests/test_tasks.py (1)
          tests/test_views.py (1)
          Makefile (1)
          requirements.txt (1)
    
        Age stats:
              Youngest PR : 0.0d: 250: Update to use Buildhub2
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 250: Update to use Buildhub2
    
    
      All repositories:
    
        Total closed issues: 8
        Total merged PRs: 43
    
    
    Contributors
    ============
    
      [:philipp]
      abillings
      adrian
      ajones
      Andrew McCreight [:mccr8]
      Brian Pitts
      Brindusa Tot[:brindusat]
      camelia.badau
      choller
      chris.lonnen
      Christian Holler (:decoder)
      Christoph Kerschbaumer [:ckerschb]
      ciprian.georgiu
      ckerschb
      continuation
      cornel.ionce
      Cristian Comorasu, QA [:ccomorasu], Release Desktop QA
      cristian.baica
      cristian.fogel
      daniel.cicas
      dveditz
      Fox one
      gsvelto
      haftandilian
      hosselot
      jbonisteel
      jcristau
      jdragojevic
      jgilbert
      John Whitlock [:jwhitlock]
      madperson
      Maria Berlinger [:maria_berlinger], Release Desktop QA
      mcastelluccio
      me
      mh+mozilla
      mozilla+bugcloser
      mozillamarcia.knous
      nical.bugzilla
      Nicholas Nethercote [:njn]
      Nicolas Silva [:nical]
      oana.botisan
      rvandermeulen
      spohl.mozilla.bugs
      tgrabowski
      timea.zsoldos
      tmaity
      vlad.lucaci
      vseerror
      Will Kahn-Greene [:willkg] ET needinfo? me
      yoasif
