.. title: Input status: August 4th, 2014
.. slug: input_status_20140804
.. date: 2014-08-04 11:28
.. tags: mozilla, work, input, dev, python


Summary
=======

This is the status report for development on `Input <https://input.mozilla.org>`_.
I publish a status report to the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_ every couple of weeks
or so covering what was accomplished and by whom and also what I'm
focusing on over the next couple of weeks. I sometimes ruminate on some
of my concerns. I think one time I told a joke.

Work summary
============

* Continued work on the development environment with awesome help from L. Guruprasad
* Implement the bits required to support Loop
* Add smoketest coverage for Firefox OS feedback form
* Fix some technical debt issues


Development
===========

Landed and deployed:

* 6097571 [:bz:`1040919`] Change version to only have one dot
* dcf8f91 [:bz:`1040919`] Fix .0.0 versions to .0
* 4012933 Remove CEF-related things
* 4887c49 [:bz:`1030905`] Add product/version tests
* 1bdd3a8 [:bz:`1042222`] update Vagrantfile to use 14.04 LTS (L. Guruprasad)
* c1bdfbb Add L. Guruprasad to CONTRIBUTORS
* 3e607a5 [:bz:`1042560`] Remove unused packages in dev VM (L. Guruprasad)
* c0759d1 Update django-mozilla-product-details
* bcf8ec8 Update product details
* 58579ab [:bz:`987801`] peep-ify requirements
* 248b0ab [:bz:`987801`] Exit if requirements are mismatched
* 5db57bc [:bz:`987801`] Redo how we figure out whether to use vendor/
* df8400d Fix sampledata generation to use bulk create
* fa0caac [:bz:`1041622`] Capture querystring slop
* 98745b5 [:bz:`1021155`] Add basic FirefoxOS smoketest
* 6cf9e39 [:bz:`1041664`] Capture slop in Input API
* ff4b711 Show context in response view
* 976ebbf [:bz:`1045942`] Add category to response table
* 34622ad Add docs for category and extra context for Input API
* d1a8dd5 Add an additional note about keys
* fec1319 [:bz:`998726`] Quell Django warnings
* 288afe4 Rename fjord/manage.py to fjord/manage_utils.py
* d40e8a9 Update dennis to v0.4.3

Landed, but not deployed:

* 28cd90f [:bz:`1047681`] Fix mlt call to be more resilient

Current head: 28cd90f


Over the next two weeks
=======================

1. Keep an eye out for any Loop or Heartbeat related work--that's top priority.
2. Work on gradient support and product picker support


What I need help with
=====================

1. (Google chrome, JavaScript, CSS, HTML) Investigate what's wrong with the date picker in Chrome and fix it [:bz:`1012965`]

2. Test out the Getting Started instructions. We've had a few people go through these already, but it's definitely worth having more eyes. http://fjord.readthedocs.org/en/latest/getting_started.html


If you're interested in helping, let me know! We hang out on ``#input`` on irc.mozilla.org and there's the `input-dev mailing list
<https://mail.mozilla.org/listinfo/input-dev>`_.


That's it!
