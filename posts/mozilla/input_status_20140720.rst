.. title: Input status: July 20th, 2014
.. slug: input_status_20140720
.. date: 2014-07-20 11:37
.. tags: mozilla, work, input, dev, python


Summary
=======

This is the status report for development on `Input <https://input.mozilla.org>`_.
I publish a status report to the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_ every couple of weeks
or so covering what was accomplished and by whom and also what I'm
focusing on over the next couple of weeks. I sometimes ruminate on some
of my concerns. I think one time I told a joke.

Last status report was at the end of June. This status report covers the
last few things we landed in 2014q2 as well as everything we've done so
far in 2014q3.

Development
===========

Landed and deployed:

* 6ecd0ce [:bz:`1027108`] Change default doc theme to mozilla sphinx (Anna Philips)
* 070f992 [:bz:`1030526`] Add cors; add api feedback get view 
* f6f5bc9 [:bz:`1030526`] Explicitly declare publicly-visible fields 
* c243b5d [:bz:`1027280`] Add GengoHumanTranslater.translate; cleanup 
* 3c9cdd1 [:bz:`1027280`] Add human tests; overhaul Gengo tests 
* ff39543 [:bz:`1027280`] Add support for the Gengo sandbox 
* 258c0b5 [:bz:`1027280`] Add test for get_balance 
* 44dd8e5 [:bz:`1027280`] Implement Gengo Human push_translations 
* 35ae6ec [:bz:`1027280`] Clean up API code 
* a7bf90a [:bz:`1027280`] Finish pull_translations and tests 
* c9db147 [:bz:`1027286`] Gengo translation system status 
* f975f3f [:bz:`1027291`] Implement spot Gengo human translation 
* f864b6b [:bz:`1027295`] Add translation_sync cron job 
* c58fd44 [:bz:`1032226`] en-GB should copyover, too 
* 7480f87 [:bz:`1032226`] Tweak the code to be more defensive 
* 7ac1114 [:bz:`1032571`] CSRF exempt the API 
* ac856eb [:bz:`1032571`] Fix tests to catch csrf issues in the api 
* 74e8e09 [:bz:`1032967`] Handle unsupported language pairs 
* 74a409e [:bz:`1026503`] First pass at vagrantification 
* a7a440f Continued working on docs; ditched hacking howto 
* 44e702b [:bz:`1018727`] Backfill translations 
* 69f9b5b Fix date_end issue 
* e59d4f6 [:bz:`1033852`] Better handle unsupported src languages 
* cc3c4d7 Add list of unsupported languages to admin 
* 32e7434 [:bz:`1014874`] Fix translate ux 
* 672abba [:bz:`1038774`] Hide responses from hidden products 
* e23eca5 Fix a goof in the last commit 
* 6f78e2e [:bz:`947767`] Nix authentication for API stuff 
* a9f2179 Fix response view re: non-existent products 
* e4c7c6c [Bug 1030905] fjord feedback api tests for dates (Ian Kronquist)
* 0d8e024 [:bz:`935731`] Add FactoryBoy 
* 646156f Minor fixes to the existing API docs 
* f69b58b [:bz:`1033419`] Heartbeat backend prototype 
* f557433 [:bz:`1033419`] Add docs for heartbeat posting 

Landed, but not deployed:

* 7c7009b [:bz:`935731`] Switch all tests to use FactoryBoy 
* 2351fb5 Generate locales so ubuntu will quite whining (Ian Kronquist)

Current head: 7ea9fc3


High-level
==========

At a high level, this is:

1. Landed automated Gengo human translation and a bunch of minor fixes to make it work more smoothly.

2. Reworked how we build development environments to use vagrant. This radically simplifies the instructions and should make it a lot easier for contributors to build a development environment. This in turn should lead to more people working on Input.

3. Fixed a bug where products marked as "hidden" were still showing up in the dashboard.

4. Implemented a GET API for Input responses. (https://wiki.mozilla.org/Firefox/Input/Dashboards_for_Everyone)

5. Implemented the backend for the Heartbeat prototype. (https://wiki.mozilla.org/Firefox/Input/Heartbeat)

6. Also, I'm fleshing out the Input section in the wiki complete with project plans. (https://wiki.mozilla.org/Firefox/Input)


Over the next two weeks
=======================

1. Continue fleshing out project plans for in-progress projects on the wiki.

2. Gradient sentiment and product picker work.


What I need help with
=====================

1. We have a new system for setting up development environments. I've tested it on Linux. Ian has, too (pretty sure he's using Linux). We could use some help testing it on Windows and Mac OSX.

Do the instructions work on Windows? Do the instructions work on Mac OSX? Are there important things the instructions don't cover? Is there anything confusing?

http://fjord.readthedocs.org/en/latest/getting_started.html

2. I'm changing the way I'm managing Fjord development. All project plans will be codified in the wiki. A rough roadmap of which projects are on the drawing board, in-progress, completed, etc is also on the wiki. I threw together a structure for all of this that I think is good, but it could use some review.

Do these project plans provide useful information? Are there important questions that need answering that the plans do not answer?

https://wiki.mozilla.org/Firefox/Input


If you're interested in helping, let me know! We hang out on ``#input`` on irc.mozilla.org and there's the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_.

I think that covers it!
