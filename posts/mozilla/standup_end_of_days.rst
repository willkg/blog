.. title: Standup report: End of days
.. slug: standup_end_of_days
.. date: 2018-08-29 8:00
.. tags: mozilla, webdev, work, standup, story

What is Standup?
================

`Standup <http://standu.ps/>`_ is a system for capturing standup-style posts
from individuals making it easier to see what's going on for teams and projects.
It has an associated IRC bot ``standups`` for posting messages from IRC.


Short version
=============

Standups project is done and we're going to decommission all the parts in the
next couple of months.


Long version: End of days
=========================

Paul and I run Standups and have for a couple of years now. We do the vast
bulk of work on it covering code changes, feature implementing, bug fixing,
site administration and user support. Neither of us use it.

There are occasional contributions from other people, but not enough to keep
the site going without us.

Standups has a lot of issues and a crappy UI/UX. Standups continues to accrue
technical debt.

The activity seems to be dwindling over time. Groups are going elsewhere.

In June, I wrote :doc:`Standup report: June 8th, 2018 <standup_report_20180608>`
in which I talked about us switching to swag-driven development as a way to
boost our energy level in the project, pull in contributors, etc. We added
a link to the site. It was a sort of last-ditch attempt to get the project
going again.

Nothing happened. I heard nothing from anyone about the post.

Sometimes, it's hard to know when a project is dead. You sometimes have
metrics that could mean something about the health of a project, but it's hard
to know for sure. Sometimes it's hard to understand why you're sitting in
a room all by yourself. Will something happen? Will someone show up? What
if we just wait 15 minutes more?

I don't want to wait anymore. The project is dead. If it's not actually
really totally dead, it's such a fantastic fascimile of dead that I can't
tell the difference. There's no point in me waiting anymore; nothing's going
to change and no one is going to show up.

Sure, maybe I could wait another 15 minutes--what's the harm since it's so
easy to just sit and wait? The harm is that I've got so many things on my
plate that are more important and have more value than this project. Also,
I don't really like working on this project. All I've experienced in the
last year was the pointy tips of bug reports most of them related to
authentication. The only time anyone appreciates me spending my very very
precious little free time on Standups is when I solicit it.

Also, I don't even know if it's "Standups" with an "s" or "Standup" without
the "s". It might be both. I'm tired of looking it up to avoid embarrassment.


Timeline for shutdown
=====================

Shutting down projects like Standups is tricky and takes time and energy.
I think tentatively, it'll be something like this:

* **August 29th** -- Announce end of Standups. Add site message (assuming
  site comes back up). Adjust irc bot reply message.
* **October 1st** -- Shut down IRC bots.
* **October 15th** -- Decommission infrastructure: websites, DNS records,
  Heroku infra; archive github repositories, etc.

I make no promises on that timeline. Maybe things will happen faster or
slower depending on circumstances.


What we're not going to do
==========================

There are a few things we're definitely not going to do when decommissioning:

First, **we will not be giving the data to anyone**. No db dumps, no db
access, nothing. If you want the data, you can slurp it down via the existing
APIs on your own. [#]_

Second, **we're not going to keep the site going in read-only mode**. No
read-only mode or anything like that unless someone gives us a really really
compelling reason to do that and has a last name that rhymes with Honnen.
If you want to keep a historical mirror of the site, you can do that on your
own.

Third, **we're not going to point www.standu.ps or standu.ps at another
project**. Pretty sure the plan will be to have those names point to nothing
or something like that. IT probably has a process for that.

.. [#] Turns out when we did the rewrite in 2016, we didn't reimplement
   the GET API. `Issue 478 <https://github.com/mozilla/standup/issues/478>`_
   covers creating a temporary new one. If you want it, please help them out.


Alternatives for people using it
================================

If you're looking for alternatives or want to discuss alternatives with
other people, check out `issue 476
<https://github.com/mozilla/standup/issues/476>`_.


But what if you want to save it!
================================

Maybe you want to save it and you've been waiting all this time for just
the right moment? If you want to save it, check out `issue 477
<https://github.com/mozilla/standup/issues/477>`_.


Many thanks!
============

Thank you to all the people who worked on Standups in the early days! I
liked those days--they were fun.

Thank you to everyone who used Standups over the years. I hope it helped
more than it hindered.


**Update August 30, 2018:** Added note about GET API not existing.
