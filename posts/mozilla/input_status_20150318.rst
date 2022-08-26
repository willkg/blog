.. title: Input status: March 18th, 2015
.. slug: input_status_20150318
.. date: 2015-03-18 16:00
.. tags: mozilla, work, input, dev, python


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

* new Alerts API
* Heartbeat fixes
* bunch of other minor fixes and updates

Thank you to contributors!:

* L Guruprasad: 6
* Ricky Rosario: 2

Landed and deployed:

* 73eaaf2 :bz:`1103045` Add create survey form (L. Guruprasad)
* e712384 :bz:`1130765` Implement Alerts API 
* 6bc619e :bz:`1130765` Docs fixes for the alerts api 
* 1e1ca9a :bz:`1130765` Tweak error msg in case where auth header is missing 
* 067d6e8 :bz:`1130765` Add support for Fjord-Authorization header 
* 1f3bde0 :bz:`909011` Handle amqp-specific indexing errors 
* 3da2b2d Fix alerts_api requests examples 
* 601551d Cosmetic: Rename heartbeat/views.py to heartbeat/api_views.py 
* 8f3b8e8 :bz:`1136810` Fix UnboundLocalError for "showdata" 
* 1721758 Update help_text in api_auth initial migration 
* 473e900 Fix migration for fixing AlertFlavor.allowed_tokens 
* 2d3d05a :bz:`1136809` Fix (person, survey, flow) uniqueness issues 
* 3ce45ec Update schema migration docs regarding module-level docstrings 
* 2a91627 :bz:`1137430` Validate sortby values 
* 6e3961c Update setup docs for django 1.7. (Ricky Rosario)
* 6739af7 :bz:`1136814` Update to Django 1.7.5 
* 334eed7 Tweak commit msg linter 
* ac35deb :bz:`1048462` Update some requirements to pinned versions. (Ricky Rosario)
* 8284cfa Clarify that one token can GET/POST to multiple alert flavors 
* 7a60497 :bz:`1137839` Add start_time/end_time to alerts api 
* 7a21735 Fix flavor.slug tests and eliminate needless comparisons 
* 89dbb49 :bz:`1048462` Switch some github url reqs to pypi 
* e1b62b5 :bz:`1137839` Add start_time/end_time to AlertAdmin 
* 3668585 :bz:`1103045` Add update survey form (L. Guruprasad)
* ab706c6 :bz:`1139510` Update selenium to 2.45 
* 6df753d Cosmetic: Minor cleanup of server error testing 
* 1dcaf62 Make throw_error csrf exempt 
* ceb53eb :bz:`1136840` Fix error handling for better debugging 
* 92ce3b6 :bz:`1139545` Handle all exceptions 
* e33cf9f :bz:`1048462` Upgrade gengo-python from 0.1.14 to 0.1.19 
* 4a8de81 :bz:`1048462` Remove nuggets 
* ff9f01c :bz:`1139713` Add received_ts field to hb Answer model 
* d853fa9 :bz:`1139713` Fix received_ts migration 
* ae5cb13 :bz:`1048462` Upgrade django-multidb-router to 0.6 
* 649b136 :bz:`1048462` Nix django-compressor 
* 1547073 Cosmetic: alphabetize requirements 
* e165f49 Add note to compiled reqs about py-bcrypt 
* ecdd00f :bz:`1136840` Back out new WSGIHandler 
* cc75bef :bz:`1141153` Upgrade Django to 1.7.6 
* d518731 :bz:`1136840` Back out rest of WSGIHandler mixin 
* 12940b0 :bz:`1139545` Wrap hb integrity error with logging 
* 8b61f14 :bz:`1139545` Fix "get or create" section of HB post view 
* d44faf3 :bz:`1129102` ditch ditchchart flag (L. Guruprasad)
* 7fa256a :bz:`1141410` Fix unicode exception when feedback has invalid unicode URL (L. Guruprasad)
* c1fe25a :bz:`1134475` Cleanup all references to input-dev environment (L. Guruprasad)

Landed, but not deployed:

* 1cac166 :bz:`1081177` Rename feedback api and update docs 
* 026d9ae :bz:`1144476` stop logging update_ts errors (L. Guruprasad)

Current head: 9b3e263


Rough plan for the next two weeks
=================================

1. removing settings we don't need and implementing environment-based
   configuration for instance settings
2. preparing for 2015q2


End of OPW and thank you to Adam!
=================================

March 9th was the last day of OPW. Adam did some really great work on Input
which is greatly appreciated. We hope he sticks around with us. Thank you,
Adam! 
