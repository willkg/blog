.. title: Input status: December 18th, 2014
.. slug: input_status_20141218
.. date: 2014-12-19 14:20
.. tags: mozilla, work, dev, input, python


Preface
=======

It's been 3 months since the last status report. Crimey! That's not great, but
it's even worse because it makes this report very long.

First off, lots of great work done by Adam Okoye, L. Guruprasad, Bhargav
Kowshik, and Deshraj Yadav! w00t!

Second, we did a ton of stuff and broke 1,000 commits! w00t!

Third, I've promised to do more frequent status reports. I'll go back to one
every two weeks.

Onward!


Development
===========

High-level summary:

* Lots of code quality work.
* Updated ElasticUtils to 0.10.1 so we can upgrade our Elasticsearch cluster.
* Heartbeat v2.
* Overhauled the generic feedback form.
* remote-troubleshooting data capture.
* contribute.json file.
* Upgrade to Django 1.6.
* Upgrade to Python 2.7!!!!!
* Improved and added to pre-commit and commit-msg linters.

Landed and deployed:

* ce95161 Clarify source and campaign parameters in API 
* 286869e :bz:`788281` Add update_product_details to deploy 
* bbedc86 :bz:`788281` Implement basic events API 
* 1c0ff9f :bz:`1071567` Update ElasticUtils to 0.10.1 
* 7fd52cd :bz:`1072575` Rework smart_timedelta 
* ce80c56 :bz:`1074276` Remove abuse classification prototype 
* 7540394 :bz:`1075563` Fix missing flake8 issue 
* 11e4855 :bz:`1025925` Change file names (Adam Okoye)
* 23af92a :bz:`1025925` Change all instances of fjord.analytics.tools to fjord.analytics.utils (Adam Okoye)
* ae28c60 :bz:`1025925` Change instances of of util relating to fjord/base/util.py (Adam Okoye)
* bc77280 Add Adam Okoye to CONTRIBUTORS 
* 545dc52 :bz:`1025925` Change test module file names 
* fc24371 :bz:`1041703` Drop prodchan column 
* 9097b8f :bz:`1079376` Add error-email -> response admin view 
* d3cfdfe :bz:`1066618` Tweak Gengo account balance warning 
* a49f1eb :bz:`1020303` Add rating column 
* 55fede0 :bz:`1061798` Reset page number Resets page number when filter checkbox is checked (Adam Okoye)
* 1d4fd00 :bz:`854479` Fix ui-lightness 404 problems 
* a9bf3b1 :bz:`940361` Change size on facet calls 
* c2b2c2b :bz:`1081413` Move url validation code into fjord_utils.js Rewrote url validation code that was in generic_feedback.js and added it to fjord_utils.js (Adam Okoye)
* 4181b5e :bz:`1081413` Change code for url validation (Adam Okoye)
* 2cd62ad :bz:`1081413` Add test for url validation (Adam Okoye)
* f72652a :bz:`1081413` Correct operator in test_fjord_utils.js (aokoye)
* c9b83df :bz:`1081997` Fix unicode in smoketest 
* cba9a2d :bz:`1086643` :bz:`1086650` Redo infrastructure for product picker version 
* e8a9cc7 :bz:`1084387` Add on_picker field to Product 
* 2af4fca :bz:`1084387` Add on_picker to management forms 
* 1ced64a :bz:`1081411` Create format test (Adam Okoye)
* 00f8a72 Add template for mentored bugs 
* e95d0f1 Cosmetic: Move footnote 
* d0cb705 Tweak triaging docs 
* d5b35a2 :bz:`1080816` Add A/B for ditching chart 
* fa1a47f Add notes about running tests with additional warnings 
* ddde83c Fix mimetype -> content_type and int division issue 
* 2edb3b3 :bz:`1089650` Add a contribute.json file (Bhargav Kowshik)
* d341977 :bz:`1089650` Add test to verify that the JSON is valid (Bhargav Kowshik)
* dcb9380 Add Bhargav Kowshik to CONTRIBUTORS 
* 7442513 Fix throttle test 
* f27e31c :bz:`1072285` Update Django, django-nose and django-cache-machine 
* dd74a3c :bz:`1072285` Update django-adminplus 
* ececdf7 :bz:`1072285` Update requirements.txt file 
* 6669479 :bz:`1093341` Tweak Gengo account balance warning 
* f233aab :bz:`1094197` Fix JSONObjectField default default 
* 11193d7 Tweak chart display 
* 9d311ca Make journal.Record not derive from ModelBase 
* f778c9d Remove all Heartbeat v1 stuff 
* e5f6f4d Switch test__utils.py to test_utils.py 
* cab7050 :bz:`1092296` Implement heartbeat v2 data model 
* 5480c42 :bz:`1097352` Response view is viewable by all 
* 46b5897 :bz:`1077423` Overhaul generic feedback form dev 
* da31b47 :bz:`1077423` Update smoke tests for generic feedback form dev 
* e84094b Fix l10n email template 
* d6c8ea9 Remove gettext calls for product dashboards 
* e1a0f74 :bz:`1098486` Remove under construction page 
* 032a660 Fix l10n_status.py script history table 
* 19cec37 Fix JSONObjectField 
* 430c462 Improve display_history for l10n_status 
* d6c18c6 Windows NT 6.4 -> Windows 10 
* 73a4225 :bz:`1097847` Update django-grappelli to 2.5.6 
* 4f3b9c7 :bz:`1097847` Fix custom views in admin 
* 3218ea3 Fix JSONObjectfield.value_to_string 
* 67c6bf9 Fix RecordManager.log regarding instances 
* a5e8610 :bz:`1092299` Implement Heartbeat v2 API 
* 17226db :bz:`1092300` Add Heartbeat v2 debugging views 
* 11681c4 Rework env view to show python and django version 
* 9153802 :bz:`1087387` Add feedback_response.browser_platform 
* f5d8b56 :bz:`1087387` :bz:`1096541` Clean up feedback view code 
* c9c7a81 :bz:`1087391` Fix POST API user-agent inference code 
* 4e93fc7 :bz:`1103024` Gengo kill switch 
* de9d1c7 Capture the user-agent 
* 4796e4e :bz:`1096541` Backfill browser_platform for Firefox dev 
* f5fe5cf :bz:`1103141` Add experiment_version to HB db and api 
* 98c40f6 :bz:`1103141` Add experiment_version to views 
* 0996148 :bz:`1103045` Create a menial hb survey view 
* 965b3ee :bz:`1097204` Rework product picker 
* 6907e6f :bz:`1097203` Add link to SUMO 
* e8f3075 :bz:`1093843` Increase length of product fields 
* 2c6d24b :bz:`1103167` Raise GET API throttle 
* d527071 :bz:`1093832` Move feedback url documentation 
* 6f4eb86 Abstract out python2.6 in deploy script 
* f843286 Fix compile-linted-mo.sh to take pythonbin as arg 
* 966da77 Add celery health check 
* 1422263 Add space before subject of celery health email 
* 5e07dbd [heartbeat] Add experiment1 static page placeholders 
* 615ccf1 [heartbeat] Add experiment1 static files 
* d8822df [heartbeat] Add SUMO links to sad page 
* 3ee924c [heartbeat] Add twitter thing to happy page 
* d87a815 [heartbeat] Change thank you text 
* 06e73e6 [heartbeat] Remove cruft, fix links 
* 8208a72 [heartbeat] Fix "addons" 
* 2eca74c [heartbeat] Show profile_age always because 0 is valid 
* 4c4598b :bz:`1099138` Fix "back to picker" url 
* b2e9445 Add note about "Commit to VCS" in l10n docs 
* 9c22705 Heartbeat: instrument email signup, feedback, NOT Twitter (Gregg Lind)
* 340adf9 [heartbeat] Fix DOCTYPE and ispell pass 
* 486bf65 [heartbeat] Change Thank you text 
* d52c739 [heartbeat] Switch to use Input GA account 
* f07716b [heartbeat] Fix favicons 
* eff9d0b [heartbeat] Fixed page titles 
* 969c4a0 [heartbeat] Nix newsletter form for a link 
* dce6f86 [heartbeat] Reindent code to make it legible 
* dad6d82 :bz:`1099138` Remove [DEV] from title 
* 4204b43 fixed typo in getting_started.rst (Deshraj Yadav)
* 7042ead :bz:`1107161` Fix hb answers view 
* a024758 :bz:`1107809` Fix Gengo language guesser 
* 808fa83 :bz:`1107803` Rewrite Response inference code 
* d9e8ffd :bz:`1108604` Tweak paging links in hb data view 
* 00e8628 :bz:`1108604` Add sort and display ts better in hb data view 
* 17b908a :bz:`1108604` Change paging to 100 in hb data view 
* 39dc943 :bz:`1107083` Backfill versions 
* fee0653 :bz:`1105512` Rip out old generic form 
* b5bb54c Update grappelli in requirements.txt file 
* f984935 :bz:`1104934` Add ResponseTroubleshootingInfo model 
* c2e7fd3 :bz:`950913` Move 'TRUNCATE_LENGTH' and make accessable to other files (Adam Okoye)
* b6f30e1 :bz:`1074315` Ignore deleted files for linting in pre-commit hook (L. Guruprasad)
* 4009a59 Get list of .py files to lint using just git diff (L. Guruprasad)
* c81da0b :bz:`950913` Access TRUNCATE_LENGTH from generic_feedback template (Adam Okoye)
* 9e3cec6 :bz:`1111026` Fix hb error page paging 
* b89daa6 Dennis update to master tip 
* 61e3e18 Add django-sslserver 
* 93d317b :bz:`1104935` Add remote.js 
* ad3a5cb :bz:`1104935` Add browser data section to generic form 
* cc54daf :bz:`1104935` Add browserdata metrics 
* 31c2f74 Add jshint to pre-commit hook (L. Guruprasad)
* 68eae85 Pretty-print JSON blobs in hb errorlog view 
* 8588b42 :bz:`1111265` Restrict remote-troubleshooting to Firefox 
* b0af9f5 Fix sorby error in hb data view 
* 8f622cf :bz:`1087394` Add browser, browser_version, and browser_platform to response view (Adam Okoye)
* c4b6f85 :bz:`1087394` Change Browser Platform label (Adam Okoye)
* eb1d5c2 Disable expansion of $PATH in the provisioning script (L. Guruprasad)
* 59eebda Cosmetic test changes 
* aac733b :bz:`1112210` Tweak remote-troubleshooting capture 
* 6f24ce7 :bz:`1112210` Hide browser-ask by default 
* 278095d :bz:`1112210` Note if we have browser data in response view 
* 869a37c :bz:`1087395` Add fields to CSV output (Adam Okoye)

Landed, but not deployed:

* 4ee7fd6 Update the name of the pre-commit hook script in docs (L. Guruprasad)
* d4c5a09 :bz:`1112084` create requirements/dev.txt (L. Guruprasad)
* 4f03c48 :bz:`1112084` Update provisioning script to install dev requirements (L. Guruprasad)
* 03c5710 Remove instructions for manual installation of flake8 (L. Guruprasad)
* a36a231 :bz:`1108755` Add a git commit message linter (L. Guruprasad)

Current head: f0ec99d


Rough plan for the next two weeks
=================================

1. PTO. It's been a really intense quarter (as you can see) and I need some
   rest. Maybe a nap. Plus we have a deploy freeze through to January, so we
   can't push anything out anyhow. I hope everyone else gets some rest, too.

That's it!
