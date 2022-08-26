.. title: Input status: August 19th, 2014
.. slug: input_status_20140819
.. date: 2014-08-19 14:11
.. tags: mozilla, work, dev, input, python


Development
===========

High-level summary:

It's been a slower two weeks than normal, but we still accomplished some interesting things:

* L Guruprasad finished cleaning up the Getting Started guide--that
  work helps all future contributors. He did a really great job with
  it. Thank you!

* Landed a minor rewrite to rate-limiting/throttling.

* Redid the Elasticsearch indexing admin page.

* Fixed some Heartbeat-related things.


Landed and deployed:

* cf2e0e2 [:bz:`948954`] Redo index admin
* f917d41 Update Getting Started guide to remove submodule init (L. Guruprasad)
* 5eb6d6d Merge pull request #329 from lgp171188/peepify_submodule_not_required_docs
* c168a5b Update peep from v1.2 to v1.3
* adf7361 [:bz:`1045623`] Overhaul rate limiting and update limits
* 7647053 Fix response view
* f867a2d Fix rulename
* 8f0c36e [:bz:`1051214`] Clean up DRF rate limiting code
* 0f0b738 [:bz:`987209`] Add django-waffle (v0.10)
* b52362a Make peep script executable
* 461c503 Improvie Heartbeat API docs
* 8f0ccd3 [:bz:`1052460`] Add heartbeat view
* d1604f0 [:bz:`1052460`] Add missing template

Landed, but not deployed:

* ed2923f [:bz:`1015788`] Cosmetic: flake8 fixes (analytics)
* afdfc6a [:bz:`1015788`] Cosmetic: flake8 fixes (base)
* 05e0a33 [:bz:`1015788`] Cosmetic: flake8 fixes (feedback)
* 2d9bc26 [:bz:`1015788`] Cosmetic: flake8 fixes (heartbeat)
* dc6e990 Add anonymize script

Current head: dc6e990


Rough plan for the next two weeks
=================================

1. Working on Dashboards-for-everyone bits. Documenting the GET
   API. Making it a bit more functional. Writing up some more
   examples. (https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone)

2. Update Input to ElasticUtils v0.10 (:bz:`1055520`)

3. Land all the data retention policy work (:bz:`946456`)

4. Gradients (https://wiki.mozilla.org/Firefox/Input/Gradient_Sentiment)

5. Product administration views (:bz:`965796`)

Most of that is in some state of half-done, so we're going to spend
the next couple of weeks focusing on finishing things.


What I need help with
=====================

1. (django) Update to django-rest-framework 2.3.14 (:bz:`934979`) -- I
   think this is straight-forward. We'll know if it isn't if the tests
   fail.

2. (django, cookies, debugging) API response shouldn't create anoncsrf
   cookie (:bz:`910691`) -- I have no idea what's going on here because
   I haven't looked into it much.

3. (html) Fixing the date picker in Chrome (:bz:`1012965`) -- The issue
   is identified. Someone just needs to do the fixing.

For details, see our GetInvolved page:

https://wiki.mozilla.org/Webdev/GetInvolved/input.mozilla.org

If you're interested in helping, let me know! We hang out on
``#input`` on irc.mozilla.org and there's the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_.


Additional thoughts
===================

We're in the process of doing a Personally Identifiable Information
audit on Input, the systems it's running on and the processes that
touch and move data around. This covers things like "what data are we
storing?", "where is the data stored?", "who/what has access to that
data?", "does that data get copied/moved anywhere?", "who/what has
access to where the data gets copied/moved to?", etc.

I think we're doing pretty well. However, during the course of the
audit, we identified a few things we should be doing better. Some of
them already have bugs, one of them is being worked on already and the
others need to be written up.

Some time this week, I'll turn that into a project and write up
missing bugs.

That's about it!
