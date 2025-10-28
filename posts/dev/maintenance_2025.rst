.. title: Open Source Project Maintenance 2025
.. slug: maintenance_2025
.. date: 2025-10-28 10:00:00 UTC-04:00
.. tags: mozilla, work, markus, kent, everett, dev, bleach, fillmore, python
.. type: text

Every October, I do a maintenance pass on all my projects. At a minimum, that
involves dropping support for whatever Python version is no longer supported
and adding support for the most recently released Python version. While doing
that, I go through the issue tracker, answer questions, and fix whatever I can
fix. Then I release new versions. Then I think about which projects I should
deprecate and figure out a deprecation plan for them.

This post covers the 2025 round.

TL;DR

* `sphinx-js <https://pypi.org/project/sphinx-js/>`__ -- transferred to
  `pyodide organization <https://github.com/pyodide>`__
* `crashstats-tools <https://pypi.org/project/crashstats-tools/>`__ and
  `siggen <https://pypi.org/project/siggen/>`__ -- transferred to the Mozilla
  crash ingestion team, which I'm no longer on
* `paul-mclendahand <https://pypi.org/project/paul-mclendahand/>`__ -- deprecated and archived
* `pip-stale <https://github.com/willkg/pip-stale/>`__ -- deprecated and archived
* `everett <https://pypi.org/project/everett/>`__ -- released v3.5.0, then deprecated and archived
* `fillmore <https://pypi.org/project/fillmore/>`__ -- released v2.2.0, then deprecated and archived
* `kent <https://pypi.org/project/kent/>`__ -- released v2.2.0
* `markus <https://pypi.org/project/markus/>`__ -- released v5.2.0
* `bleach <https://pypi.org/project/bleach/>`__ -- released v6.3.0


.. TEASER_END

Prior to the October maintenance pass
=====================================

Over the course of 2025, I deprecated or transferred some of the libraries I
owned. Some of them because my role at Mozilla changed dramatically and some of
them because it was time.

* `sphinx-js <https://pypi.org/project/sphinx-js/>`__ (which I "owned" for a
  short time) was transferred to the `pyodide project
  <https://github.com/pyodide/sphinx-js>`__.

* `paul-mclendahand <https://pypi.org/project/paul-mclendahand/>`__ was
  deprecated and archived at the tail end of 2024. I don't think I mentioned
  that. I don't think there were many users other than myself.

* `crashstats-tools <https://pypi.org/project/crashstats-tools/>`__ was transferred
  to the Mozilla team that now owns the crash ingestion pipeline project.

* `siggen <https://pypi.org/project/siggen/>`__ was transferred to the Mozilla team
  that now owns the crash ingestion pipeline project.

* `pip-stale <https://github.com/willkg/pip-stale/>`__ was deprecated and
  archived; I never actually released this, but I wrote and used it until I
  switched everything to a `uv <https://docs.astral.sh/uv/>`__ based workflow.

* `rob-bugson <https://addons.mozilla.org/en-US/firefox/addon/rob-bugson/>`__
  was deprecated.

I started most of those projects, the exception being sphinx-js, which I
inherited. I will miss working on them. I wish them well.

That leaves Everett, Fillmore, Kent, Markus, and Bleach.


Everett
=======

I started `Everett <https://pypi.org/project/everett/>`__ in August 2016
because I needed a configuration library that met the requirements for the
crash ingestion system I was maintaining so that I could deprecate
`configman <https://pypi.org/project/configman/1.3.0/>`__. I wanted a library
that supported autodocumentation and facilitated easier testing. Everett was
a good project. Over 9 years, I did 22 releases.

Recently, I became aware of `pydantic-settings
<https://pypi.org/project/pydantic-settings/>`__ and as I looked over the
documentation, it seemed likely that it did the bulk of what Everett does, minus the
autodocumentation and convenient testing harness. In May 2025, I was moved to a
different project at Mozilla and no longer use Everett.

.. thumbnail:: /images/everett_downloads_2025.png

   *Everett downloads in 2025-04-21 through 2025-10-13. 480k / month. (pypistats.org)*


Given that, I decided it made sense to deprecate it.

I wrote up my thoughts in `this comment
<https://github.com/willkg/everett/issues/278#issuecomment-3402632166>`__ which
includes experimentation with converting Everett-using code to
pydantic-settings-using code. I released Everett v3.5.0 and deprecated it.


Fillmore
========

I started `Fillmore <https://pypi.org/project/fillmore/>`__ in June 2022
because we were moving from an in-house managed instance of Sentry to a Sentry
(the company) managed Sentry (the service) and the crash ingestion system I
worked on had pretty strict data policies because errors sent to Sentry could
contain sensitive data from users' crash reports.

In order to make this problem quantifiable (i.e., exactly what gets sent to
Sentry?, does it change over time as I update the sentry-sdk library?, how do I
know my filtering code is working?), I wrote Fillmore, which allowed me to:

* centralize a very specific, very paranoid Sentry configuration which I
  could use and maintain across multiple projects
* establish a framework to write scrubbers, taking into account the case where
  scrubbers throw an error, making sure that both errors make it to Sentry and
  it doesn't fail invisibly
* write tests that guaranteed errors that follow sensitive paths in crash
  ingestion code didn't contain sensitive data

It was a good project. It allowed me to transition crash ingestion services
to the Sentry (the company) managed Sentry (the service) while meeting the strict
requirements of crash ingestion data policies. I did 11 releases.

Since I wrote Fillmore, Sentry (the company) focused on improving their
sensitive-data story. The default configuration and event payload are better
documented. In May 2025, I was moved to a different project at Mozilla
and no longer use Fillmore. Fillmore wasn't really used by anyone else.

.. thumbnail:: /images/fillmore_downloads_2025.png

   *Fillmore downloads in 2025-04-14 through 2025-10-06. 561 / month. (pypistats.org)*


Given that, I decided it made sense to deprecate it.

I wrote up my thoughts in `this comment
<https://github.com/mozilla-services/fillmore/issues/94#issue-3379774769>`__, I
released Fillmore v2.2.0, and deprecated the project.


Kent
====

I started `Kent <https://pypi.org/project/kent/>`__ in June 2022 when I was
working on Fillmore. I needed a service that I could run in a local development
environment on my laptop to capture Sentry sentry-sdk request payloads and then
display them in a way I could debug Fillmore issues. Eventually, Kent grew a
better API that allows people to use it in test environments to test Sentry
sentry-sdk integration.

Kent is missing support for some key Sentry functionality, like spans and some
of the other observability features. Kent development has slowed way down and
Kent isn't really in use.

.. thumbnail:: /images/kent_downloads_2025.png

   *Kent downloads in 2025-05-05 through 2025-10-27. 4k / month. (pypistats.org)*


I think Kent is not long for this world, but I decided to continue maintaining
and supporting it for now.

I released Kent v2.2.0.


Markus
======

I started `Markus <https://pypi.org/project/markus/>`__ in April 2017. We had
StatsD code all over the place across multiple projects and it was inconsistent.
There was no way to validate that metrics get generated correctly in tests and there
was no way to determine what metrics were emitted for a project. Markus fixed a
lot of those problems. Further, the way it was structured made adding metrics
to code much easier because it mimicked the Python logging module and decoupled
the metrics client from the metrics backends.

Markus is StatsD-centric. That was helpful years ago, but now we're moving to
Prometheus and OpenTelemetry. Markus' API has the wrong shape for bolting on
Prometheus or OpenTelemetry support. I would need to write a new library.
Markus is used by multiple services at Mozilla, but not well used outside of
Mozilla.

.. thumbnail:: /images/markus_downloads_2025.png

   *Markus downloads in 2025-05-05 through 2025-10-27. 13k / month. (pypistats.org)*


I think Markus' days are numbered, but I decided to continue maintaining and
supporting Markus for now.

I released Markus v5.2.0.


Bleach
======

James Socol started `Bleach <https://pypi.org/project/bleach/>`__ in February 2010.
I took over Bleach in May 2016. I took a hiatus from February 2020 through
April 2022, where I helped with Bleach, but Greg Guthe was the primary
maintainer. In April 2022, I took over maintenance again and have been
maintaining it ever since. When Bleach first started, it filled a critical void
for sanitizing user-generated content for HTML contexts. It was a critical
security library for Mozilla services like MDN, SUMO, Input, Addons, and others. It
was used in readme-renderer, which was used in PyPI and a variety of other
Python projects and services.

Bleach sits on top of the `html5lib <https://pypi.org/project/html5lib/>`__
library and depends upon that library for the HTML parser. I acted as a
temporary maintainer for html5lib to push the project over the 1.0.0 hump.
Since then, it has largely been inactive. It hasn't had a release since June 2020.
Bleach vendors this library and we apply several patches to it to fix issues in
Bleach, but this is not a tenable situation. I talk about this in
:doc:`my post about Bleach 6.0.0 release and deprecation <bleach_6_0_0_deprecation>`
from January 2023. Nothing has changed since then.

I was hoping the `HTML Sanitizer API
<https://developer.mozilla.org/en-US/docs/Web/API/HTML_Sanitizer_API>`__ would
be further along by now. I think that model is more correct and safer than
using Bleach.

Bleach is still in heavy use.

.. thumbnail:: /images/bleach_downloads_2025.png

   *Bleach downloads in 2025-05-05 through 2025-10-27. 45m / month. (pypistats.org)*

Bleach is deprecated, but I'll continue to minimally maintain Bleach for now. I
released Bleach v6.3.0.


Conclusion
==========

I finished up my maintenance pass and I whittled down the number of libraries
I'm maintaining to three.
