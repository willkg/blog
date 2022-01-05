.. title: Kent v0.1.0 released! And the story of Kent in the first place....
.. slug: kent_0_1_0
.. date: 2022-01-04 20:00
.. tags: python, dev, kent, sentry

What is it?
===========

Before explaining what it is, I want to talk about Why.

A couple of years ago, we migrated from the Raven Sentry client (Python) to
sentry-sdk. One of the things we did was implement our own sanitization code
which removed personally identifyable information and secret information (as
best as possible) from error reports.

I find the documentation for writing sanitization filters really confusing.
``before_send``? ``before_breadcrumb``? When do those hooks kick off? What does
an event look like? There's `a link to a page that describes an event
<https://develop.sentry.dev/sdk/event-payloads/>`_, but there's a lot of
verbiage and no schema so it's not wildly clear what the errors my application
is sending look like. [1]_

Anyhow, so when we switched to sentry-sdk, we implemented some sanitization
code because while Raven had some code, sentry-sdk did not. Then at some point
between then and now, the sanitization code stopped working. It's my fault
probably. I bet something changed in the sentry-sdk and I didn't notice.

Why didn't I notice? Am I a crappy engineer? Sure, but in this case the problem
here is that the sanitization code runs in the context of handling an unhandled
error. In handling the unhandled error, Sentry passes the event through our
broken sanitization code and that throws an exception. Nothing gets sent to
Sentry--neither the original error nor the sanitization error.

Once I realized there were errors, I looked in the logs and I can see the
original errors--but not the sanitization errors.

.. Note:: 

   Fun fact: turns out John Whitlock thought about this when he wrote the
   sanitization code and added some code to emit a metric if the sanitization
   code errors out. If I had a graph in the dashboard showing this metric, I
   would have seen it.


"You should test your sanitization code!" you say! Right on! That's what we
should be doing! We have *unit tests* but they run with ficticious data in a
pocket dimension. So they passed wonderfully despite the issue!

What we needed was a few things:

1. I needed to be able to run a fake Sentry service that I could throw errors
   at and debug the sanitization code in my local environment without having to
   spin up a real Sentry instance
2. I needed to be able to see exactly what is in the error payloads for my
   application.
3. I needed something I can use for integration tests with the sentry-sdk.

That's how I ended up putting aside all the things I needed to do and built
Kent.

.. [1] I don't intend to bash Sentry and the Sentry folks and all the work they
       do. Their docs may be great. I'm probably the dumb one here.


So what is Kent?
================

Kent is a fake Sentry service. You can run it, set the Sentry DSN of your
application to soemthing like ``http://public@localhost:8000/1``, and then Kent
will capture Sentry error reports.

Kent takes 2 seconds to set up. You can run it locally::

    $ pip install kent
    $ kent-server run

You can run it in a Docker container. There's a sample ``Dockerfile`` in the
repo.

It doesn't require databases, credentials, caching, or any of that stuff.

Kent stores things in-memory. You don't have to clean up after it.

Kent has a website letting you view errors with your browser.

Kent has an API letting you build integration tests that create the errors and
then fetch them and assert things against them.


What questionable architectural decisions did you make?
=======================================================

I built it with `Flask <https://flask.palletsprojects.com/>`_. Flask is great
for stuff like this--that part is fine.

The part that's less fine is that I decided to put in the least amount of
effort in standing it up as a service and putting it behind a real WSGI server,
so I'm (ab)using Flask's cli and monkeypatching werkzeug to not print out
"helpful" (but in this case--unhelpful) messages to the console.

I used `pico.css <https://picocss.com/>`_ because I read about it like
yesterday and it seemed easier to use that than to go fiddling with CSS
frameworks to get a really lovely looking site for a fake Sentry service.

I may replace that at some point with something that involves less horizontal
space.

I only wrote one test. I have testing set up, but only wrote one test to make
sure it's minimally viable. I may write more at some point.

I only tested with Python sentry-sdk. I figure if other people need it, they
can let me know what else it works with and we can fix any issues that come up.

I decided to store errors in memory rather than persist things to disk. That
was easy to do and seems like the right move. Maybe we'll hit something that
requires us to do something different.

I named it Kent. I like short names. Friends suggested I name it Caerbannog
because it was a sentry of a sort. I love that name, but I can't reliably spell
it.


0.1.0 released!
===============

I thought about making this 1.0.0, but then decided to put it into the world
and use it for a bit and fix any issues that come up and *then* release 1.0.0.

Initial release with minimally viable feature set.

* capture errors and keep them in memory
* API endpoint to list errors
* API endpoint to fetch error


Where to go for more
====================

History of releases:
https://github.com/willkg/kent/blob/main/HISTORY.rst

Source code, issue tracker, documentation, and quickstart here:
https://github.com/willkg/kent

Let me know how this helps you!

I say that in a lot of my posts. "Let me know how this helps you!" or "Comment
by sending me an email!" or something like that. I occasionally get a
response--usually from Sumana--but most often, it's me talking to the void. I
do an awful lot of work that theoretically positively affects thousands of
people to be constantly talking to the void.

Let me know if you have positive or negative feelings about Kent by:

1. click on this link: https://github.com/willkg/kent/issues/3
2. add a reaction to the description which should be like two clicks
