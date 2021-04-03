.. title: Input status: February 4th, 2015
.. slug: input_status_20150204
.. date: 2015-02-04 14:20
.. tags: mozilla, work, dev, input, python



What is it?
===========

The purpose of `Input <https://input.mozilla.org/>`_ is to collect
actionable feedback from our user base across each channel of our
software development process. The application collects feedback and
offers a set of analysis methods for looking at the resulting data. 

`Project site <https://wiki.mozilla.org/Firefox/Input>`_.

This is a status post about Input.

.. TEASER_END


Preface
=======

Since the last status report, we did a year-in-review and probably some other
emails, so I figured I'd hold off on a status report until mid-January. I
missed that by a couple of weeks.


Development
===========

High-level summary:

1. Lots of fixes and improvements to documentation, git hooks, test infrastructure and setting up development environments

2. Heartbeat v2

3. Browser data capture

4. Upgraded libraries in preparation for upgrading to Django 1.7

5. Scaffolding for the new Thank You page

6. Switched from in-house Jenkins to Travis-CI


Thank you to contributors!:

* Adam Okoye: 3
* Adrian Gaudebert: 1
* L Guruprasad: 9
* Ricky Rosario: 14
* deshraj: 3


Landed and deployed:

* a88a25a Ignore the commented lines in commit message before linting it (L. Guruprasad)
* 1fc67a3 :bz:`1110543` Add noscript section (Adam Okoye)
* 1d608c4 :bz:`1116543` Peg pip at 1.5.6 
* 5256b31 Add ihavepower command 
* f9f789a :bz:`1116498` Fix date filter API tests 
* c33c398 Improve data migration docs 
* 6d69baf Fix qunit tests; spruce up qunit docs 
* 43ec5da Handle whitespace URLs 
* 0aa0245 Fix commit message lint to gracefully handle empty commit message (L. Guruprasad)
* fff1101 :bz:`1091716` Allow about: and chrome:// URLs in client-side validation (L. Guruprasad)
* 575fceb Fix jshint errors in generic_feedback.js (L. Guruprasad)
* 74c3ed8 Remove analytics_flagged view. (Ricky Rosario)
* 2b58388 :bz:`1091716` Update smoketests regarding url validation changes 
* 2e006e9 Remove fjord/analytics/templates/analytics/analyzer/flags.html (Ricky Rosario)
* 6a1ad6d :bz:`1091716` Add smoketest for whitespace in url data 
* 7cf5b3c :bz:`1091716` Carry changes over to generic_feedback_dev.js 
* 18e5c89 Nix last vestiges of schematic 
* 6661094 :bz:`1114335` Record what happened when purge_data script ran, in journal (L. Guruprasad)
* 58fcfcf Update purge_data test to cover RemoteTroubleshootingInfo objects 
* 342eac3 :bz:`1108156` Upgrade peep and handle pip 6.0 
* de4621e :bz:`1119015` Fix API with ES 1.2.4 
* 4c5072b :bz:`900992` Update south to 1.0.2 
* 0fd833c :bz:`900992` Update south in vendor/ to 1.0.2 
* 565e05d :bz:`1093222` Stop using django-cache-machine. (Ricky Rosario)
* 53d8043 :bz:`1093222` Removing django-cache-machine from vendor. (Ricky Rosario)
* 0a47fdc :bz:`1093222` Remove django-cache-machine from peep requirements. (Ricky Rosario)
* 28ad328 :bz:`1116523` Add response ID to session (Adam Okoye)
* ae85859 :bz:`1119972` Fix remote-troubleshooting checkbox 
* 19fd092 back button hit area increased in generic_feedback.html (deshraj)
* 39a9099 Document how to configure the timezone of the VM to match the host (L. Guruprasad)
* 55aa382 :bz:`1105435` Increasing Hit Target of Back Button (deshraj)
* 9921759 :bz:`1116838` Create waffle flag for thank you page (Adam Okoye)
* 06e7eb6 Add l10n comment to clarify "Submit" string 
* 33e9f9e No bug - Fixed l10n documentation and added l10n dependencies to vagrant. (Adrian Gaudebert)
* 1c6eda9 :bz:`1122060` add description for heartbeat survey model (L. Guruprasad)
* 8396274 :bz:`1071044` Initial travis setup. (Ricky Rosario)
* 08baebb :bz:`1119305` Upgrade django to 1.6.10 
* 92b275e :bz:`1104863` Upgrade to celery v3.1.17 (Ricky Rosario)
* 1e3bb5c :bz:`1123744` Nix jenkins 
* 60553bc :bz:`1120952` Fix remotetroubleshooting metrics 
* 16250bf Tweak reverse to allow you to override the locale 
* 7398332 :bz:`1124497` Add ResponsePI table and migration 
* 61a57e2 :bz:`1124497` Move ResponseTroubleshootingInfo to ResponsePI 
* 899c7a0 :bz:`1124497` Delete ResponseTroubleshootingInfo 
* 36eb60b :bz:`990777` Add high resolution images for favicon for retina displays (L. Guruprasad)
* ba498e3 :bz:`1126030` Enable CORS for Heartbeat API. (Ricky Rosario)
* 74dfc6d Handle Windows 10 user agents in sniffer 
* 301e9e5 :bz:`1054001` Upgrade to django-browserid v0.11.1 (Ricky Rosario)
* 2c76974 :bz:`1127312` Document how to keep up with changes to fjord (L. Guruprasad)
* 6fe9630 :bz:`934979` Upgrade django rest framework to v2.4.4 (Ricky Rosario)
* a6b396b :bz:`1111641` Enable browser data capture for all locales 
* 94b5292 :bz:`1127431` Add survey filtering to hbdata view 
* 15b19b2 :bz:`1113171` Remove requests 1.1.0 
* 83079bf :bz:`1113171` Upgrade to requests 2.5.1 
* 5f5b93d :bz:`1118765` Upgrade jingo to master tip. (Ricky Rosario)
* 0bb2e56 :bz:`1124379` Upgrade peep and un-goofify it 
* b5676cf :bz:`1118765` Upgrade waffle to v0.10.1 for django 1.7 (Ricky Rosario)
* 997702f :bz:`1076879` Fix Response indexing retry 
* deaa5eb :bz:`1111265` Fix browser data re: products and browsers 
* 540b404 :bz:`1111265` Add browser_data_browser to admin and forms 
* 16f0a78 :bz:`1119813` Merge browser data ask branch 
* 2ef8099 Update peep to 2.2 

Current head: d3fe0fc


Rough plan for the next two weeks
=================================

1. Adam is working on the new Thank You page
2. Ricky is working on updating all the things so that we can upgrade to Django 1.7
3. I'm working on fleshing out the Alerts project plan
4. I'm working on the implementation work for the Gradient Sentiment project


That's it!
