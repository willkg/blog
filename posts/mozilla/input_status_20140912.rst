.. title: Input status: September 12th, 2014
.. slug: input_status_20140912
.. date: 2014-09-12 16:20
.. tags: mozilla, work, dev, input, python



Development
===========

High-level summary:

* Updated to ElasticUtils v0.10 which will allow us to upgrade our
  cluster to Elasticsearch 1.1. I'm working on a fix that'll let us to
  go to Elasticsearch 1.2, but that hasn't been released, yet.

* Integrated the spicedham library prototype and set it up to classify
  abusive Input feedback. It's not working great, but that's entirely
  to be expected. I'm hoping to spend more time on spicedham and
  classification in Input in 2014q4. Ian did a great job with laying
  the foundation! Thank you, Ian!

* Implemented a data retention policy and automated data purging.

* Made some changes to the Input feedback GET and POST APIs to clarify
  things in the docs, fix some edge cases and make it work better for
  Firefox for Android and Loop.

* Fixed the date picker in Chrome. Thank you, Ruben!


Landed and deployed:

* c4e8e34 [:bz:`1055520`] Update to ElasticUtils v0.10
* e023fa4 [:bz:`1055520`] Fix two reshape issues post EU 0.10 update
* f9ba829 [:bz:`1055785`] Codify data retention policy
* 91396a8 Generalize About page text so it works for all products
* 6fc03bf [:bz:`1053863`] Update django to 1.5.9
* 85709b2 [:bz:`1055788`] Implement data purging
* c0677a1 [:bz:`965796`] Add a products update page
* 121588d [:bz:`1057353`] Update django-statsd and pystatsd
* fe1c740 Add PII-related notes to the API fields
* f77ecfa [:bz:`799562`] Clarify API field documentation
* c5eec03 [:bz:`1055789`] Restrict front page dashboard and api to 6 months
* 0892546 [:bz:`1059826`] Add max_length to url field in API
* f192f84 [:bz:`1057617`] Fix url data validation
* aad961d [:bz:`1030901`] Document Input GET API
* 2f212c5 [:bz:`1015788`] Add flake8 linting
* d673947 Update coding conventions
* 27a1b6b Add "maximum" arg to GET API
* 4f671e4 [:bz:`1062436`] Add flags app and Flag model
* 9d03d4b Fix flake8_lint issues
* 0411d91 [:bz:`1062453`] Add flagged view
* 56f7e24 [:bz:`1062439`] Celery task for classification
* 7aa2930 [:bz:`1062455`] Add spicedham to vendor (Ian Kronquist)
* 0d90df3 We don't need spicedham under vendor/packages (Ian Kronquist)
* a2a491d fix :bz:`1012965` - Date picker looks broken in chrome (Ruben Vereecken)
* 0c42213 [:bz:`1063825`] Integrate spicedham into fjord
* 78a2d63 [:bz:`1062444`] Initial training data
* 5ca816e [:bz:`1020307`] Prepare for adding gradient to generic form

Current head: 5ca816e



Rough plan for the next two weeks
=================================

1. Working on Dashboards-for-everyone bits. Documenting the GET
   API. Making it a bit more functional. Writing up some more
   examples. (https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone)

2. Gradients (https://wiki.mozilla.org/Firefox/Input/Gradient_Sentiment)


What I need help with
=====================

1. (django) Update to django-rest-framework 2.3.14 (bug #934979) -- I
   think this is straight-forward. We'll know if it isn't if the tests
   fail.

2. (django, cookies, debugging) API response shouldn't create anoncsrf
   cookie (bug #910691) -- I have no idea what's going on here because
   I haven't looked into it much.

For details, see our GetInolved page:

https://wiki.mozilla.org/Webdev/GetInvolved/input.mozilla.org

If you're interested in helping, let me know! We hang out on
``#input`` on irc.mozilla.org and there's the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_.


Additional thoughts
===================

I've been codifying project plan details on the wiki:

https://wiki.mozilla.org/Firefox/Input

I have no idea who's going to use that information or whether it helps.
If you see things that are missing, let me know. It'll help me hone the 
project management templates I'm using and know which information is 
important to keep up to date and which information I can let slide 
until rainy days.

That's it!
