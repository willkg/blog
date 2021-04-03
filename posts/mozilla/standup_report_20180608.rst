.. title: Standup report: June 8th, 2018
.. slug: standup_report_20180608
.. date: 2018-06-08 8:00
.. tags: mozilla, webdev, work, standup

What is Standup?
================

`Standup <http://standu.ps/>`_ is a system for capturing standup-style posts
from individuals making it easier to see what's going on for teams and projects.
It has an associated IRC bot ``standups`` for posting messages from IRC.


Project report
==============

Over the last six months, we've done:

* monthly library updates
* revamped static assets management infrastructure
* service maintenance
* fixed the textarea to be resizeable (Thanks, Arai!)

The monthly library updates have helped with reducing technical debt. That takes
a few hours each month to work through.

Paul redid how Standup does static assets. We no longer use django-pipeline, but
instead use gulp. It works muuuuuuch better and makes it possible to upgrade to
Djagno 2.0 soon. That was a ton of work over the course of a few days for both
of us.

We've been keeping the Standup service running. That includes stage and
production websites as well as stage and production IRC bots. That also includes
helping users who are stuck--usually with accounts management. That's been a
handful of hours.

Arai fixed the textareas so they're resizeable. That helps a ton! I'd love to
get more help with UI/UX fixing.

Some GitHub stats::

  GitHub
  ======

    mozilla/standup: 15 prs

      Committers:
               pyup-bot :     6  (  +588,   -541,   20 files)
                 willkg :     5  (  +383,   -169,   27 files)
                   pmac :     2  ( +4179,   -223,   58 files)
                 arai-a :     1  (    +2,     -1,    1 files)
                    g-k :     1  (    +3,     -3,    1 files)

                  Total :        ( +5155,   -937,   89 files)

      Most changed files:
        requirements.txt (11)
        requirements-dev.txt (7)
        standup/settings.py (5)
        docker-compose.yml (4)
        standup/status/jinja2/base.html (3)
        standup/status/models.py (3)
        standup/status/tests/test_views.py (3)
        standup/status/urls.py (3)
        standup/status/views.py (3)
        standup/urls.py (3)

      Age stats:
            Youngest PR : 0.0d: 466: Add site-wide messaging
         Average PR age : 2.3d
          Median PR age : 0.0d
              Oldest PR : 10.0d: 459: Scheduled monthly dependency update for May


    All repositories:

      Total merged PRs: 15


  Contributors
  ============

    arai-a
    g-k
    pmac
    pyup-bot
    willkg


That's it for the last six months!


Switching to swag-driven development
====================================

Do you use Standup?

Did you use Standup, but the glacial pace of fixing issues was too much so you
switched to something else?

Do you want to use Standup?

We think there's still some value in having Standup around and there are still
people using it. There's still some technical debt to fix that makes working on
it harder than it should be. We've been working through that glacially.

As a project, we have the following problems:

1. The bulk of the work is being done by Paul and Will.
2. We don't have time to work on Standup.
3. There isn't anyone else contributing.

Why aren't users contributing? Probably a lot of reasons. Maybe everyone has
their own reason! Have I spent a lot of time to look into this? No, because I
don't have a lot of time to work on Standup.

Instead, we're just going to make some changes and see whether that helps. So
we're doing the following:

1. Will promises to send out Standup project reports every 6 months before the
   All Hands and in doing this raise some awareness of what's going on and thank
   people who contributed.

2. We're fixing the Standup site to be clearer on who's doing work and how
   things get fixed so it's more likely your ideas come to fruition rather than
   get stale.

3. We're switching Standup to swag-driven development!

What's that you say? What's swag-driven development?

I mulled over the idea in :doc:`my post on swag-driven development <swag_driven_development>`.

It's a couple of things, but mainly an explicit statement that people work on
Standup in our spare time at the cost of not spending that time on other things.
While we don't feel entitled to feeling appreciated, it would be nice to feel
appreciated sometimes. Not feeling appreciated makes me wonder whether I should
spend the time elsewhere. (And maybe that's the case--I have no idea.) Maybe
other people would be more interested in spending their spare time on Standup if
they knew there were swag incentives?

So what does this mean?

It means that we're encouraging swag donations!

* If your team has stickers at the All Hands and you use Standup, find Paul and
  Will and other Standup contributors and give them one!

* If there are features/bugs you want fixed and they've been sitting in the
  queue forever, maybe bribing is an option.


For the next quarter
====================

Paul and I were going to try to get together at the All Hands and discuss what's
next.

We don't really have an agenda. I know I look at the issue tracker and go, "ugh"
and that's about where my energy level is these days.

Possible things to tackle in the next 6 months off the top of my head:

* update to Django 2.0 (https://github.com/mozilla/standup/issues/464)
* ability to retire projects (https://github.com/mozilla/standup/issues/451)
* write tests for things--we have terrible test coverage at the moment

If you're interested in meeting up with us, toss me an email at `willkg at
mozilla dot com`.
