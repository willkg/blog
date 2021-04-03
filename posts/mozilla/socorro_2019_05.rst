.. title: Socorro: May 2019 happenings
.. slug: socorro_2019_05
.. date: 2019-06-12 12:00
.. tags: mozilla, work, socorro, dev

Summary
=======

`Socorro <https://github.com/mozilla-services/socorro>`_ is the crash ingestion
pipeline for Mozilla's products like Firefox. When Firefox crashes, the crash
reporter collects data about the crash, generates a crash report, and submits
that report to Socorro. Socorro saves the crash report, processes it, and
provides an interface for aggregating, searching, and looking at crash reports.

This blog post summarizes Socorro activities in May.


.. TEASER_END

Highlights of May
=================

* Continued to onboard John.

* Tecken: Finished audit, added OIDCProvider for local development,
  improved README and documentation, updated dependencies.

* Buildhub2: Worked on audit, improved documentation, fixed dev
  environment, updated dependencies.

* Socorro: Removed Fira use from Crash Stats site, updated dependencies,
  removed last uses of ``six``, fixed ``JitCrashCategorizeRule``, patched
  over problem where Rust 1.34 symbols are missing the module, fixed
  minidump-stackwalk errors, switched to sentry-sdk.


Bugzilla and GitHub stats for May
=================================

::

    Bugzilla
    ========
    
      Bugs created: 53
      Creators: 13
    
           Will Kahn-Greene [:willkg] ET  : 32
               John Whitlock [:jwhitlock] : 9
           Marcia Knous [:marcia - needin : 2
           Kohei Yoshino [:kohei] (Bugzil : 1
               Gabriele Svelto [:gsvelto] : 1
                               [:philipp] : 1
                   Kannan Vijayan [:djvj] : 1
           Jeff Muizelaar [:jrmuizel] On  : 1
                            Asif Youssuff : 1
           Liz Henry (:lizzard) (use need : 1
           Emilio Cobos Álvarez (:emilio) : 1
           Bogdan Maris [:bogdan_maris],  : 1
              Mihai Boldan, QA [:mboldan] : 1
    
      Bugs resolved: 42
    
                                    FIXED : 41
                                  WONTFIX : 1
    
      Resolvers: 5
    
           Will Kahn-Greene [:willkg] ET  : 27
               John Whitlock [:jwhitlock] : 12
               Calixte Denizet (:calixte) : 1
                              Brian Pitts : 1
           Emilio Cobos Álvarez (:emilio) : 1
    
      Commenters: 17
    
                                   willkg : 198
                                jwhitlock : 60
                                  gsvelto : 11
                                     kats : 7
                                 cdenizet : 6
                                   emilio : 5
                               jmuizelaar : 3
                                      jan : 2
                      mozillamarcia.knous : 2
                                   lhenry : 2
                                 kvijayan : 2
                                   sledru : 1
                                 jcristau : 1
                                madperson : 1
                                   sdetar : 1
                                   bpitts : 1
                                pulgasaur : 1
    
      Tracker bugs: 0
    
    
      Statistics
    
          Youngest bug : 0.0d: 1548158: remove socorro/external/postgres/
       Average bug age : 38.3d
        Median bug age : 4.0d
            Oldest bug : 633.0d: 1393889: build local dev env for development and testing...
    
    GitHub
    ======
    
      mozilla-services/socorro:
    
        Merged PRs: 36
    
        * 4959: bug 1544552: Add `BaseAllocator` to the prefix signature list (glandium)
        * 4957: bug 1473068: Expand OIDC_EXEMPT_URLS for more XHR usage (jwhitlock)
        * 4956: bug 1554986: fix __len__ in ExpiringCache (willkg)
        * 4935: bug 1513346: Migrate six.reraise to standard raise (jwhitlock)
        * 4955: Revert "bug 1553314: default to old keys for environment variables" (willkg)
        * 4954: bug 1553314: default to old keys for environment variables (willkg)
        * 4953: bug 1553838: fix JitCrashCategorizeRule (willkg)
        * 4952: bug 1553314: remove configuration from Rules (willkg)
        * 4949: Bug 1553665 - Add libc to the signature prefixes. (emilio)
        * 4951: bug 1544246: add "fix_missing_module" pass to signature generation (willkg)
        * 4950: bug 1553314: move and rename rules and pipeline (willkg)
        * 4948: bug 1553327: cronrun: log, don't capture exception (jwhitlock)
        * 4947: bug 1407212: remove unused super_search_fields code (willkg)
        * 4945: bug 1553251: Remove bad params from mdsw command (jwhitlock)
        * 4944: bug 1393889: add elasticsearch7 service (willkg)
        * 4943: bug 1552973: Log missing boto files as warnings (jwhitlock)
        * 4942: Add BugSplat to list of hosted solutions (bobbyg603)
        * 4941: Document deploys and PII request processing (willkg)
        * 4940: bug 1543097: Sanitize ELB headers  (jwhitlock)
        * 4939: bug 1543097: Do not send DisallowedHost to Sentry (jwhitlock)
        * 4917: Bug 1543097: Convert crash reporting from raven to sentry_sdk (jwhitlock)
        * 4938: bug 1549297: fix android manufacturer faceting (willkg)
        * 4936: bug 1549717: fix std::out_of_range error and module assert in minidump-stackwalk (willkg)
        * 4934: bug 1550028: Switch to crash-stats.mozilla.org (jwhitlock)
        * 4928: bug 1513346: Convert six to native Python 3 (jwhitlock)
        * 4933: bug 1550043: rough mdswshell and docs (willkg)
        * 4932: Update reprocessing docs (jwhitlock)
        * 4930: Socorro Updates, May 2019 (jwhitlock)
        * 4929: bug 1549540: surface signal issues from minidump-stackwalk (willkg)
        * 4926: bug 1548830: Fix API token examples (jwhitlock)
        * 4924: bug 1545426: don't include ESR versions in featured versions (willkg)
        * 4925: bug 1543988: update breakpad client to 4d550cceca107f36c4bc1ea1126b7d… (willkg)
        * 4923: bug 1546672: fix supersearch versions suggestions to include X.Yb (willkg)
        * 4922: bug 1544565: rename white/blacklist to allow/disallowlist (willkg)
        * 4921: bug 1547807: add __str__ to Job and Log (willkg)
        * 4919: bug 1548158: remove postgres code (willkg)
    
        Committers:
                   willkg :    20  (  +979,  -2032,   61 files)
                jwhitlock :    13  ( +1177,   -567,   80 files)
                 glandium :     1  (    +1,     -0,    1 files)
                   emilio :     1  (    +2,     -2,    1 files)
                bobbyg603 :     1  (    +1,     -1,    1 files)
    
                    Total :        ( +2160,  -2602,  131 files)
    
        Most changed files:
          socorro/processor/processor_pipeline.py (5)
          webapp-django/crashstats/settings/base.py (3)
          requirements/default.txt (3)
          socorro/processor/processor_app.py (3)
          webapp-django/crashstats/supersearch/models.py (3)
          socorro/processor/processor_2015.py (3)
          socorro/unittest/processor/test_mozilla_transform_rules.py (3)
          webapp-django/crashstats/crashstats/utils.py (3)
          socorro/signature/siglists/prefix_signature_re.txt (2)
          requirements/constraints.txt (2)
    
        Age stats:
              Youngest PR : 0.0d: 4959: bug 1544552: Add `BaseAllocator` to the prefix ...
           Average PR age : 1.1d
            Median PR age : 0.0d
                Oldest PR : 19.0d: 4935: bug 1513346: Migrate six.reraise to standard raise
    
      mozilla-services/antenna:
    
      mozilla-services/tecken:
        Closed issues: 13
                                   willkg : 1
    
        Merged PRs: 10
    
        * 1817: Pin mozillaparsys/oidc_testprovider Docker tag (renovate[bot])
        * 1816: bug 1552901: Use oidcprovider in local dev (jwhitlock)
        * 1809: Finish unfinished paragraph in benchmarking docs (willkg)
        * 1808: bug 1552867: remove New Relic bits; add Sentry links (willkg)
        * 1805: Add webapp test docs (willkg)
        * 1803: Add test plan (willkg)
        * 1801: Convert README and move most of it to docs (willkg)
        * 1800: Upgrade to psycopg2 2.8.2 to quell warning (willkg)
        * 1796: minor project fixes (willkg)
        * 1798: Update libraries (willkg)
    
        Committers:
                   willkg :     8  (  +582,   -384,   67 files)
            renovate[bot] :     1  (    +1,     -1,    1 files)
                jwhitlock :     1  (  +209,    -28,    8 files)
    
                    Total :        (  +792,   -413,   73 files)
    
        Most changed files:
          docs/dev.rst (6)
          requirements.txt (3)
          docker/images/oidcprovider/Dockerfile (2)
          tecken/settings.py (2)
          .pyup.yml (2)
          .env-dist (1)
          docker-compose.yml (1)
          docker/images/oidcprovider/fixtures.json (1)
          docs/authentication.rst (1)
          docs/configuration.rst (1)
    
        Age stats:
              Youngest PR : 0.0d: 1817: Pin mozillaparsys/oidc_testprovider Docker tag
           Average PR age : 0.0d
            Median PR age : 0.0d
                Oldest PR : 0.0d: 1817: Pin mozillaparsys/oidc_testprovider Docker tag
    
      mozilla-services/buildhub2:
        Closed issues: 4
                                   willkg : 4
    
        Merged PRs: 11
    
        * 586: Update axios to 0.19.0 (willkg)
        * 585: Fix dev environment (willkg)
        * 583: Upgrade to node 10.6.0 (willkg)
        * 580: Fix make-tag to make a signed tag (willkg)
        * 579: Nix Merge commits in tag comment (willkg)
        * 578: Add whatsdeployed link (willkg)
        * 576: Update Sphinx (willkg)
        * 509: Update postgres:9.6 Docker digest to 78890d2 (renovate[bot])
        * 524: Update docker.elastic.co/elasticsearch/elasticsearch Docker tag to v6.7.1 (renovate[bot])
        * 575: Update Python requirements (willkg)
        * 573: Project fixes (willkg)
    
        Committers:
                   willkg :     9  (  +555,   -286,   50 files)
            renovate[bot] :     2  (    +4,     -4,    2 files)
    
                    Total :        (  +559,   -290,   51 files)
    
        Most changed files:
          Makefile (3)
          docker-compose.yml (3)
          bin/make-tag.py (3)
          ui/package.json (2)
          bin/run.sh (2)
          README.rst (2)
          docker-compose.ci.yml (2)
          ui/yarn.lock (1)
          .env-dist (1)
          bin/db.py (1)
    
        Age stats:
              Youngest PR : 0.0d: 586: Update axios to 0.19.0
           Average PR age : 12.7d
            Median PR age : 0.0d
                Oldest PR : 85.0d: 509: Update postgres:9.6 Docker digest to 78890d2
    
    
      All repositories:
    
        Total closed issues: 17
        Total merged PRs: 57
    
    
    Contributors
    ============
    
      [:philipp]
      Asif Youssuff
      bobbyg603
      Bogdan Maris [:bogdan_maris], Release Desktop QA
      Brian Pitts
      Calixte Denizet (:calixte)
      Emilio Cobos Álvarez (:emilio)
      Gabriele Svelto [:gsvelto]
      glandium
      jan
      jcristau
      Jeff Muizelaar [:jrmuizel] On leave until June 17
      John Whitlock [:jwhitlock]
      Kannan Vijayan [:djvj]
      kats
      Kohei Yoshino [:kohei] (Bugzilla UX) (FxSiteCompat)
      Liz Henry (:lizzard) (use needinfo)
      Marcia Knous [:marcia - needinfo? me]
      Mihai Boldan, QA [:mboldan]
      pulgasaur
      sdetar
      sledru
      Will Kahn-Greene [:willkg] ET needinfo? me
