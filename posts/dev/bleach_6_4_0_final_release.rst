.. title: Bleach 6.4.0 releases -- final release
.. slug: bleach_6_4_0_final_release
.. date: 2026-06-05 09:00:00 UTC-04:00
.. tags: python, dev, bleach, mozilla, story
.. type: text

What is it?
===========

`Bleach <https://bleach.readthedocs.io/>`_ is a Python library for sanitizing
and linkifying text from untrusted sources for safe usage in HTML.


Bleach v6.4.0 released!
=======================

Bleach 6.4.0 includes two security fixes, a fix to tinycss2 dependency
requirements, and some other things.

See the changes here:

https://bleach.readthedocs.io/en/latest/changes.html#version-6-4-0-june-5th-2026


Bleach v6.4.0 is the final release
==================================

I haven't used Bleach on a project in years, but I still had some time to
maintain it. That changed about a year ago when I got re-orged into a new role
and I haven't had time to do any Bleach work since then.

To recap, Bleach sits on top of
`html5lib <https://github.com/html5lib/html5lib-python>`__ which hasn't
been actively maintained in years. It is dangerous to maintain Bleach in that
context.

We vendored html5lib so we could make adjustments to the library to keep Bleach
going. This is not a sustainable approach, but it was ok for the short term.

Over the years, we've talked about other options:

1. find another library to switch to
2. take over html5lib development
3. fork html5lib and vendor and maintain our fork
4. write a new HTML parser
5. etc

None of those are feasible for me.

Bleach has been a solo-maintained project for a while now. The world is crazy
and it's much harder to build a team of trusted maintainers now than it was (or
at least, it sure feels that way). I don't see any possibility of increasing
the maintenance team or passing it to someone else responsibly.

Switching contexts from my regular work to Bleach is really hard. Bleach is
complicated, the problem domain is complicated, and there's a lot of nuanced
context. I can't just switch gears, spend 15 minutes on Bleach to do something,
and then switch back to the rest of my day. I periodically get nag messages
about this which are entirely valid, but there's nothing I can do about it.
It doesn't feel great.

Then in 2025, Emil, a long-time Bleach contributor, built
`justhtml <https://emilstenstrom.github.io/justhtml/>`__ which gives us an easy
migration path off of Bleach. He even took the time to write a
`migration guide <https://emilstenstrom.github.io/justhtml/bleach-migration.html>`__.


Thoughts and statistics
=======================

In 2019, when I stepped down the first time, I wrote
:doc:`a post on stepping down <bleach_stepping_down>`.

In 2023, when I deprecated the project, I wrote
:doc:`a post on Bleach 6.0.0 and deprecation <bleach_6_0_0_deprecation>`.

* From the first commit on 2010-02-18 to today's final commit on 2026-06-05,
  the Bleach project lasted 16 years, 3 months — 5,951 days, or about 16.29
  years.
* There were 64 releases.
* There were roughly 960 commits.

  * From 80 roughly contributors
  * Top 3:

    * Will Kahn-Greene: 462
    * James Socol: 182
    * Greg Guthe: 133

* Roughly 5,040 lines of Python code excluding the vendored html5lib.
* I was maintainer from October 2015 to now--that's a little under 11 years.

It feels weird to end a project that's outlived many of the Mozilla sites and
Python web frameworks it was designed to protect.


What happens now?
=================

This is the end of the project.

.. thumbnail:: /images/bleach_deprecation.jpg

   Bleach. Last release.


If you're still using Bleach, I think you have three options:

1. **End your project.** Maybe you don't need to be maintaining your thing
   anymore? Use Bleach as your reason to exit and do something different with
   your time on Earth.

2. **Switch to the sanitizer API.** Rework your project to use the sanitizer API.

   * Spec: https://wicg.github.io/sanitizer-api/
   * Docs: https://developer.mozilla.org/en-US/docs/Web/API/Element/setHTML

3. **Swap Bleach out for justhtml.** Emil provided a
   `migration guide <https://emilstenstrom.github.io/justhtml/bleach-migration.html>`__
   for switching from Bleach to justhtml.

Good luck with whatever option you choose!


Thanks!
=======

Many thanks to `James <https://github.com/jsocol>`__ who created Bleach and
gave it a set of first principles that guided our choices for 16 years.

Many thanks to `Greg <https://github.com/g-k>`__ who I worked with on Bleach
for a long while and maintained Bleach for several years. Working with Greg was
always easy and his reviews were thoughtful and spot-on.

Many thanks to `Emil <https://github.com/EmilStenstrom>`__ who was
a contributor to Bleach for a long while and created
`justhtml <https://emilstenstrom.github.io/justhtml/>`__
providing Bleach users a migration path.

Many thanks to `Jonathan <https://github.com/jvanasco>`__ who, over the years,
provided a lot of insight into how best to solve some of Bleach's more
squirrely problems.

Many thanks to `Sam <https://github.com/gsnedders>`__ who was an indispensible
resource on HTML parsing and sanitizing text in the context of HTML.

Many thanks to all the users and contributors of Bleach!


Where to go for more
====================

For more specifics on this release, see here:
https://bleach.readthedocs.io/en/latest/changes.html#version-6-4-0-june-5th-2026

Documentation and quickstart here:
https://bleach.readthedocs.io/en/latest/

Source code and issue tracker here:
https://github.com/mozilla/bleach/
