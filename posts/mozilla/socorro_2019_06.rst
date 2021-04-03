.. title: Socorro Engineering: June 2019 happenings
.. slug: socorro_2019_06
.. date: 2019-07-02 12:00
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

This blog post summarizes our activities in June.


Highlights of June
==================

* Socorro: Fixed the collector's support of a single JSON-encoded
  field in the HTTP POST payload for crash reports. This is a big deal
  because we'll get less junk data in crash reports going forward.

* Socorro: Reworked how Crash Stats manages featured versions: if
  the product defines a ``product_details/PRODUCTNAME.json`` file,
  it'll pull from that. Otherwise it calculates featured versions
  based on the crash reports it's received.

* Buildhub: deprecated Buildhub in favor of Buildhub2. Current plan is
  to decommission Buildhub in July.

* Across projects: Updated tons of dependencies that had security
  vulnerabilities. It was like a hamster wheel of updates, PRs,
  and deploys.

* Tecken: Worked on GCS emulator for local dev environment.

* All hands discussions:

  * GCP migration plan for Tecken and figure out what needs to be done.
  * Possible GCP migration schedule for Tecken and Socorro.
  * Migrating applications using Buildhub to Buildhub2 and
    decommissioning Buildhub in July.
  * What would happen if we switched from Elasticsearch to BigQuery?
  * Switching from Socorro's minidump-stackwalk to minidump-analyzer.
  * Re-implementing the Socorro Top Crashers and Signature reports using
    Telemetry tools and data.
  * Writing a symbolicator and Socorro-style signature generator in
    Rust that can be used for crash reports in Socorro and crash pings
    in Telemetry.
  * The crash ping vs. crash report situation (blog post coming soon).


.. TEASER_END

Bugzilla and GitHub stats for June
==================================

::
    
    Bugzilla
    ========
    
      Bugs created: 42
      Creators: 19
    
           Will Kahn-Greene [:willkg] ET  : 23
           Marcia Knous [:marcia - needin : 2
                  Thom Chiovoloni [:tcsc] : 1
             Dylan Roeh (:droeh) (he/him) : 1
                          janet  [:janet] : 1
           Cornel Ionce [:cornel_ionce],  : 1
           Cristian Baica [:cbaica], Rele : 1
           Timea Zsoldos [:zstimi/tzsoldo : 1
           Camelia Badau [:cbadau], Relea : 1
           Anca Soncutean [:Anca], Deskto : 1
              Alexandru Trif, QA [:atrif] : 1
              Catalin Sasca, QA [:csasca] : 1
           Ciprian Georgiu [:ciprian_geor : 1
             Cristian Fogel, QA [:cfogel] : 1
              Vlad Lucaci, QA  (:vlucaci) : 1
           Oana Botisan, Desktop Release  : 1
           Daniel Cicas [:dcicas], Releas : 1
           Gabi Cheta [:Gabi] Release Des : 1
                 Jeff Gilbert [:jgilbert] : 1
    
      Bugs resolved: 29
    
                                    FIXED : 27
                                  WONTFIX : 1
                                  INVALID : 1
    
      Resolvers: 3
    
           Will Kahn-Greene [:willkg] ET  : 22
               John Whitlock [:jwhitlock] : 7
    
      Commenters: 24
    
                                   willkg : 115
                                jwhitlock : 12
                               tgrabowski : 5
                                wlachance : 3
                            catalin.sasca : 3
                                   fitojb : 2
                                   lhenry : 2
                                   ryanvm : 2
                             bogdan.maris : 2
                                    droeh : 2
                                  dbolter : 2
                           anca.soncutean : 2
                           alexandru.trif : 2
                                       me : 1
                                  peterbe : 1
                                pulgasaur : 1
                             mihai.boldan : 1
                      mozillamarcia.knous : 1
                                s.kaspari : 1
                                   bpitts : 1
                              tchiovoloni : 1
                              jdragojevic : 1
                                   tmaity : 1
                                  gasofie : 1
    
      Tracker bugs: 0
    
    
      Statistics
    
          Youngest bug : 0.0d: 1556802: socorro deploy: 382
       Average bug age : 22.8d
        Median bug age : 5.0d
            Oldest bug : 397.0d: 1460709: Fonts are extremely thin
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 14
    
        * 4973: bug 1561697: add mozilla::ipc::WriteIPDLParam to prefix list (willkg)
        * 4972: Update docs (willkg)
        * 4971: bug 1560998: make RemoteType private (willkg)
        * 4969: Update Fennec release version to 67.0.3 (rvandermeulen)
        * 4968: bug 1559153: remove depcheck cronrun cmd (willkg)
        * 4967: Update Fennec Nightly version to 68.0a1 (rvandermeulen)
        * 4966: bug 1552898: fix product details url (willkg)
        * 4964: bug 1552898: add product_details and validation test (willkg)
        * 4965: bug 1552898: implement manual featured versions (willkg)
        * 4958: bug 1555744: support --host and --processed in fetch_crash_data (willkg)
        * 4963: bug 1557012: add Allocator<T>::malloc to prefix list (willkg)
        * 4962: bug 1545446: fix input box widths in super search (willkg)
        * 4931: bug 1545446: Remove Fira-Sans, reduce font list (jwhitlock)
        * 4961: Update requirements, June 2019 (jwhitlock)
    
        Committers:
                   willkg :    10  (  +364,   -579,   25 files)
            rvandermeulen :     2  (    +2,     -2,    1 files)
                jwhitlock :     2  (   +67,    -55,    5 files)
    
                    Total :        (  +433,   -636,   29 files)
    
        Most changed files:
          product_details/FennecAndroid.json (4)
          webapp-django/crashstats/settings/base.py (3)
          socorro/signature/siglists/prefix_signature_re.txt (2)
          requirements/default.txt (2)
          product_details/README.rst (2)
          webapp-django/crashstats/crashstats/tests/test_utils.py (2)
          CONTRIBUTING.rst (1)
          docs/howto.rst (1)
          socorro-cmd (1)
          socorro/external/es/super_search_fields.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 4972: Update docs
           Average PR age : 2.4d
            Median PR age : 0.0d
                Oldest PR : 27.0d: 4931: bug 1545446: Remove Fira-Sans, reduce font list
    
      mozilla-services/antenna:
    
        Merged PRs: 7
    
        * 349: Update dependencies (willkg)
        * 348: bug 1560168: ignore querystring params in HTTP POSTs (willkg)
        * 347: bug 1560168: add logging for json-and-kv situation (willkg)
        * 346: bug 1559151: add pyup and set to monthly updates (willkg)
        * 318: bug 1559151: remove pyup configuration (willkg)
        * 317: bug 1557706: fix error string (willkg)
        * 316: bug 1557706: specify why crash report was discarded (willkg)
    
        Committers:
                   willkg :     7  (  +220,   -180,    5 files)
    
                    Total :        (  +220,   -180,    5 files)
    
        Most changed files:
          antenna/breakpad_resource.py (4)
          .pyup.yml (2)
          requirements/constraints.txt (1)
          requirements/default.txt (1)
          tests/unittest/test_breakpad_resource.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 349: Update dependencies
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 349: Update dependencies
    
      mozilla-services/tecken:
    
        Merged PRs: 14
    
        * 1835: Fix shields in README (willkg)
        * 1834: Update mozillaparsys/oidc_testprovider Docker digest to 876268f (renovate[bot])
        * 1832: Update node:10.16.0-slim Docker digest to 9afe43a (renovate[bot])
        * 1831: Update dependency Sphinx to v2.1.1 (renovate[bot])
        * 1828: Upgrade js-yaml (willkg)
        * 1823: Update node:10.16.0-slim Docker digest to f37262e (renovate[bot])
        * 1820: Update dependencies 20190601 (willkg)
        * 1826: Upgrade handlebars to 4.1.2 (willkg)
        * 1825: Overhaul make-tag (willkg)
        * 1821: bug 1556775: add "make setup" (willkg)
        * 1815: Update Node.js to v10.16.0 (renovate[bot])
        * 1819: Update dependency Sphinx to v2.1.0 (renovate[bot])
        * 1812: Update python:3.6-slim Docker digest to bab4801 (renovate[bot])
        * 1811: Update node:10.15.3-slim Docker digest to 5177e5d (renovate[bot])
    
        Committers:
            renovate[bot] :     8  (   +12,    -12,    4 files)
                   willkg :     6  (  +352,   -227,   16 files)
    
                    Total :        (  +364,   -239,   20 files)
    
        Most changed files:
          Dockerfile (5)
          frontend/Dockerfile (4)
          docs-requirements.txt (2)
          frontend/yarn.lock (2)
          docs/dev.rst (2)
          README.rst (1)
          docker/images/oidcprovider/Dockerfile (1)
          frontend/package.json (1)
          requirements-constraints.txt (1)
          requirements.txt (1)
    
        Age stats:
              Youngest PR : 0.0d: 1835: Fix shields in README
           Average PR age : 2.6d
            Median PR age : 0.0d
                Oldest PR : 12.0d: 1812: Update python:3.6-slim Docker digest to bab4801
    
      mozilla-services/buildhub2:

        Closed issues: 1
    
        Merged PRs: 7
    
        * 594: Fix shields in README (willkg)
        * 593: Update to prettier 1.18.2 (willkg)
        * 592: Update eslint (willkg)
        * 590: Overhaul docs (willkg)
        * 591: Fix docs building and theme (willkg)
        * 589: Fix make-tag to support other remote names (willkg)
        * 588: Updates for 20190601 (willkg)
    
        Committers:
                   willkg :     7  ( +1379,  -1955,   31 files)
    
                    Total :        ( +1379,  -1955,   31 files)
    
        Most changed files:
          requirements.txt (3)
          README.rst (2)
          ui/package.json (2)
          ui/yarn.lock (2)
          .circleci/config.yml (2)
          Makefile (2)
          docs/conf.py (2)
          bin/build-docs-locally.sh (1)
          docker-compose.ci.yml (1)
          docker-compose.yml (1)
    
        Age stats:
              Youngest PR : 0.0d: 594: Fix shields in README
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 594: Fix shields in README
    
      mozilla-services/buildhub:
    
        Merged PRs: 7
    
        * 540: Update eslint to 4.18.2 (willkg)
        * 538: Add deprecation notice to README (willkg)
        * 537: Update ui deploy (willkg)
        * 536: Redo ui deploys (willkg)
        * 535: Fix release process (willkg)
        * 534: Add deprecation notice (willkg)
        * 533: Update deps (willkg)
    
        Committers:
                   willkg :     7  ( +2506,  -2442,   10 files)
    
                    Total :        ( +2506,  -2442,   10 files)
    
        Most changed files:
          README.md (4)
          ui/package.json (3)
          ui/yarn.lock (3)
          bin/make-release.py (1)
          ui/src/App.js (1)
          ui/src/index.css (1)
          Makefile (1)
          jobs/buildhub/inventory_to_records.py (1)
          jobs/requirements/constraints.txt (1)
          kinto/Dockerfile (1)
    
        Age stats:
              Youngest PR : 0.0d: 540: Update eslint to 4.18.2
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 540: Update eslint to 4.18.2
    
      mozilla/PollBot:
        Closed issues: 3
    
        Merged PRs: 2
    
        * 248: Pin requirements, nix tox (willkg)
        * 245: project scaffolding fixes (willkg)
    
        Committers:
                   willkg :     2  (  +509,   -261,   19 files)
    
                    Total :        (  +509,   -261,   19 files)
    
        Most changed files:
          Dockerfile (2)
          requirements.txt (2)
          scripts/run-tests.sh (2)
          MANIFEST.in (1)
          constraints.txt (1)
          setup.cfg (1)
          tests/test_views.py (1)
          tox.ini (1)
          .gitignore (1)
          API_CHANGELOG.rst (1)
    
        Age stats:
              Youngest PR : 0.0d: 248: Pin requirements, nix tox
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 248: Pin requirements, nix tox
    
    
      All repositories:
    
        Total closed issues: 4
        Total merged PRs: 51
    
    
    Contributors
    ============
    
      Alexandru Trif, QA [:atrif]
      Anca Soncutean [:Anca], Desktop Release QA
      bogdan.maris
      bpitts
      Camelia Badau [:cbadau], Release Desktop QA
      Catalin Sasca, QA [:csasca]
      Ciprian Georgiu [:ciprian_georgiu], Release Desktop QA
      Cornel Ionce [:cornel_ionce], Desktop Release QA
      Cristian Baica [:cbaica], Release Desktop QA
      Cristian Fogel, QA [:cfogel]
      Daniel Cicas [:dcicas], Release QA
      dbolter
      Dylan Roeh (:droeh) (he/him)
      fitojb
      Gabi Cheta [:Gabi] Release Desktop QA
      gasofie
      janet  [:janet]
      Jeff Gilbert [:jgilbert]
      John Whitlock [:jwhitlock]
      lhenry
      Marcia Knous [:marcia - needinfo? me]
      me
      mihai.boldan
      Oana Botisan, Desktop Release QA
      peterbe
      pulgasaur
      rvandermeulen
      s.kaspari
      tgrabowski
      Thom Chiovoloni [:tcsc]
      Timea Zsoldos [:zstimi/tzsoldos], Desktop Release QA
      tmaity
      Vlad Lucaci, QA  (:vlucaci)
      Will Kahn-Greene [:willkg] ET needinfo? me
      Will Lachance
