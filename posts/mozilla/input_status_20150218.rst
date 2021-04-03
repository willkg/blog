.. title: Input status: February 18th, 2015
.. slug: input_status_20150218
.. date: 2015-02-18 10:00
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


Development
===========

High-level summary:

* Some minor fixes
* Upgraded to Django 1.7

Thank you to contributors!:

* Adam Okoye: 1
* L Guruprasad: 5 (now over 25 commits!)
* Ricky Rosario: 8

Landed and deployed:

* 57a540f Rename test_browser.py to something more appropriate 
* 6c360d9 :bz:`1129579` Fix user agent parser for firefox for android 
* 0fa7c28 :bz:`1093341` Fix gengo warning emails 
* 39f3d25 :bz:`1053384` Make the filters visible even when there are no results (L. Guruprasad)
* 9d009d7 :bz:`1130009` Add pyflakes and mccabe to requirements/dev.txt with hashes (L. Guruprasad)
* 5b5f9b9 :bz:`1129085` Infer version for Firefox Dev 
* b0e0447 :bz:`1130474` Add sample data for heartbeat 
* 91de653 Update django-celery to master tip. (Ricky Rosario)
* 6eda058 Update django-nose to v1.3 (Ricky Rosario)
* f2ba0d0 Fix docs: remove stale note about test_utils. (Ricky Rosario)
* 3b7811f :bz:`1116848` Change thank you page view (Adam Okoye)
* 8d8ee31 :bz:`1053384` Fix selected sad/happy filters not showing up on 0 results (L. Guruprasad)
* fea60dc :bz:`1118765` Upgrade django to 1.7.4 (Ricky Rosario)
* 7aa9750 :bz:`1118765` Replace south with the new django 1.7 migrations. (Ricky Rosario)
* dcd6acb :bz:`1118765` Update db docs for django 1.7 (new migration system) (Ricky Rosario)
* c55ae2c :bz:`1118765` Fake the migrations for the first deploy of 1.7 (Ricky Rosario)
* 1288d5b :bz:`1118765` Fix wsgi file 
* c9a326d :bz:`1118765` Run migrations for real during deploy. (Ricky Rosario)
* f2398c2 Add "migrate --list" to let us know migration status 
* bf8bf4c Split up peep line into multiple commands 
* 0710080 Add a "version" to the jingo requirement so it updates 
* 0d1ca43 :bz:`1131664` Quell Django 1.6 warning 
* 7545259 :bz:`1131391` update to pep8 1.6.1 (L. Guruprasad)
* 0fa0aab :bz:`1130762` Alerts app, models and modelfactories 
* be95d8e :bz:`1130469` Add filter for hb test rows and distinguish them by color (L. Guruprasad)
* f3abd8e Add help_text for Survey model fields 
* f6ba2a2 Migration for help_text fields in Survey 
* f8cd339 :bz:`1133734` Fix waffle cookie thing 
* c8a6805 :bz:`1133895` Upgrade grappelli to 2.6.3 

Current head: 11aa7a4


Rough plan for the next two weeks
=================================

1. Adam is working on the new Thank You page
2. I'm working on the Alerts API
3. I'm working on the implementation work for the Gradient Sentiment project


That's it!
