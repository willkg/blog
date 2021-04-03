.. title: Dennis Retrospective (2013)
.. slug: dennis_retrospective_2013
.. date: 2013-12-15 10:00:00 UTC-05:00
.. tags: dennis, dev, python, mozilla, story, retrospective
.. category: 
.. link: 
.. description: Recap of Dennis project
.. type: text


Project
=======

:time: 3 months
:impact:
    * fixed l10n-related HTTP 500 errors for SUMO and Input
    * paved road for MDN, AMO and other Mozilla sites to use the same strategy


Problem statement
=================

When we deploy `support.mozilla.org (SUMO) <https://support.mozilla.org/>`_ and
`Input <https://github.com/mozilla/fjord/>`_ [1]_, it fetches the most recent
localized strings ``.po`` files from SVN, compiles them to ``.mo`` files, and
ships them with the site. Becuase SUMO supports many languages and the deploy
pulls down the most recent changes, there's no way to effectively test the
entire site for all languages before deploying to production. Because of that,
users experience HTTP 500 server errors on pages that have bad strings.

.. [1] Mozilla Input has since been taken down.

When there are server errors, we get notified, write up a bug, and then have to
go fix it and push the fix out as soon as possible. Fixing issues is difficult
since we don't know most of the languages the site is translated in and our
l10n community spans many timezones, so getting help can take many hours.

That was covered roughly in :bz:`841412` for SUMO and :bz:`875313` for Input.

On top of that, SUMO sends emails to SUMO users and if the localized strings
are bad, then emails don't get sent. That's covered in :bz:`850215`.

Why are there problems in localizations? Judging by the strings we were
seeing, we think we had a few issues:

1. **The localizer changes the formatting token.**

   We're using gettext and Python and several different token formats. For
   example, ``%s``, ``%(name)s``, and ``{name}``. If the localizer changes the
   structure of the token, that will cause a server error.

2. **The localizer translates the token.**

   For example, the token is ``{name}``, but the translated token is
   ``{nombre}``.

3. **The localizer copies a string from somewhere else with different tokens.**

   For example, the string has ``{url}``, but the translated string has
   ``{helpurl}``.

Thus we're faced with:

1. a series of problems with strings that happen semi-frequently
2. server errors preventing users from seeing certain parts of SUMO
3. we can't suss out these errors by testing the whole site for every locale
   before every prod deploy
4. each server error is a priority 1 interrupt

SUMO and Input weren't the only sites that has this problem---it's a problem
for `MDN <https://developer.mozilla.org/>`_, `AMO
<https://addons.mozilla.org>`_, and other sites, too.


Solution
========

I wondered if we could effectively lint ``.po`` files during deploy and only
compile the ``.po`` files that didn't have problems. If we did that, then
the problem would stop.

I wrote a ``localelinter.py`` script in SUMO [2]_ that let me experiment with
writing a linter and tying it to the deploy process.

That went well and I wanted to use the same system for two different projects
plus I suspected others would want to use it, too. Further, we had a ``poxx.py``
script that let us debug layout problems related to translated strings and I
wanted to merge both of these into a new library.

.. [2] https://github.com/mozilla/kitsune/commit/4855c6422cf3855515d2684ac8782cbe013f0c12

I created `Dennis <https://dennis.readthedocs.io/>`_ that let you lint and
fake-translate strings.

On July 29th, I :doc:`released Dennis v0.3.3 <dennis_0_3_3>` which I felt was
good enough for us and other people to use. We switched SUMO and Input to use
it.

Our server errors from localization issues mostly ended. Periodically, we'd
encounter a new kind of issue and would improve Dennis to catch it.

We made the deploy logs viewable so linting errors could be seen, bugs could be
written, and errors could get fixed.

I talked about how we use it on Input and SUMO along with the bash script we
used that compiled ``.po`` files that linted successfully to ``.mo`` files.
MDN, AMO, and other sites switched to using Dennis thus eliminating the errors
for them, too.


Impact
======

This eliminated a frequent cause of HTTP 500 errors which caused downtime for
the site, prevented users from getting Firefox support, and created frequent
interruptions for site engineers.

Building it as a library allowed other Mozilla sites to use it eliminating the
problem for them, too.


Alternatives
============

potools
-------

The `potools <https://pypi.org/project/potools/>`_ project that had a linter,
but it:

1. didn't return a non-zero exit code when it encountered linting errors
2. performed a quality-of-string kind of linting and didn't really know about
   variables

We couldn't go with this as is and it looked too difficult to improve to meet
our needs.
