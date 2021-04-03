.. title: Site development using pagekite
.. slug: pagekite
.. date: 2014-04-09 10:00
.. tags: dev, webdev


Problem
=======

I have this basic problem where I do a lot of web-site work and I need
to show people what I've done so far so they can review it and help me
make it better or make it suit their needs better. Screenshots aren't
very helpful because the site is interactive. Further, the site needs
to get tested on multiple devices/platforms/browsers. Also, I need to
make sure that the site is only accessed via https.

What I've been doing up to now is failing miserably: I'd push work to
our staging server for people to test out, but that sucks as an answer
and affects my co-workers and makes a mess of our staging server. Plus
iterating on things is difficult.

So, requirements:

1. endpoint must be https-only
2. must be easy to set up and take down
3. must be easy to access so people can easily test things on my local
   machine


Solution
========

I looked around and this would be pretty easy to do if I didn't have
the https-only requirement. That makes things difficult without a lot
of work.

Then I found `pagekite <http://pagekite.net/>`_. They make it really
easy.

Here's how you set it up:

1. Download and install the pagekite software:
   http://pagekite.net/downloads/

2. Run your website. In my case, I'm working on Django sites, so I
   launch like this::

       $ ./manage.py runserver

   That runs the Django project I'm working on on localhost:8000.

3. Run pagekite::

       $ pagekite.py 8000 YOUR_NAME.pagekite.me:443

   That creates a tunnel from your machine to the pagekite.me
   server. When someone accesses ``https://YOUR_NAME.pagekite.me/``,
   the request goes through the tunnel to your pagekite backend and
   that performs the request over http to your local webserver (in my
   case, the Django project) bound to localhost:8000.

   Access is https-only. If anyone tries to access
   http://YOUR_NAME.pagekite.me/, then they get a connection error.

   The https-only requirement is satisfied by restricting the kite to
   only listening to port 443--the https port. That's pretty key.


This lets me run my Django project locally on http without dealing
with self-signed certificates, but still require https access so data
isn't floating around in clear text.

The one problem with this is that my local server thinks it's running
http and so redirects that include the protocol go to http rather than
https.

If you don't already have an account, I'm pretty sure step 3 will walk
you through setting one up. Free accounts are limited in what they can
do.

Also, they hang out on ``#pagekite`` on Freenode. I had a problem,
asked a question and got a super helpful reply. The code is Open
Source, so it's possible to look through it and debug it.

I'll be using this going forward.


Why write this?
===============

This is a common use case for web developers. I figured I'd write this
up because the https-only part is pretty key and it was the part that
I had to ask for help with.
