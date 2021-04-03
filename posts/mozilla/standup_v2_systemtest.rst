.. title: Standup v2: system test
.. slug: standup_v2_systemtest
.. date: 2016-09-20 11:00
.. tags: mozilla, webdev, work, standup, dev

What is Standup?
================

`Standup <http://standu.ps/>`_ is a system for capturing standup-style posts
from individuals making it easier to see what's going on for teams and projects.
It has an associated IRC bot ``standups`` for posting messages from IRC.


Join us for a Standup v2 system test!
=====================================

Paul and I did a ground-up rewrite of the Standup web-app to transition from
Persona to GitHub auth, release us from the shackles of the old architecture and
usher in a new era for Standup and its users.

We're done with the most minimal of minimal viable products. It's missing some
features that the current Standup has mostly around team management, but
otherwise it's the same-ish down to the lavish shade of purple in the header
that Rehan graced the site with so long ago.

**If you're a Standup user, we need your help testing Standup v2 on the -stage
environment before Thursday, September 22nd, 2016!**

We've thrown together a `GitHub issue
<https://github.com/mozilla/standup/issues/219>`_ to (ab)use as a forum for test
results and working out what needs to get fixed before we push Standup v2 to
production. It's got instructions that should cover everything you need to know.

Why you would want to help:

1. You get to see Standup v2 before it rolls out and point out anything that's
   missing that affects you.

2. You get a chance to discover parts of Standup you may not have known about
   previously.

3. This is a chance for you to lend a hand on this community project that helps
   you which we're all working on in our free time.

4. Once we get Standup v2 up, there are a bunch of things we can do with Standup
   that will make it more useful. Freddy is itching to fix IRC-related issues
   and wants https support [1]_. I want to implement user API tokens, a cli and
   search. Paul want's to have better weekly team reports and project pages.

   There are others listed in the issue tracker and some that we never wrote
   down.

   We need to get over the Standup v2 hurdle first.


Why you wouldn't want to help:

1. You're on PTO.

   Stop reading--enjoy that PTO!

2. It's the end of the quarter and you're swamped.

   Sounds like you're short on time. Spare a minute and do something in the
   `Short on time, but want to help anyhow? <https://github.com/mozilla/standup/issues/219>`_
   section.

3. You're looking to stop using Standup.

   I'd love to know what you're planning to switch to. If we can meet peoples'
   needs with some other service, that's more free time for me and Paul.

4. Some fourth thing I lack the imagination to think of.

   If you have some other blocker to helping, toss me an email.


Hooray for the impending Standup v2!

.. [1] This is in progress--we're just waiting for a cert.
