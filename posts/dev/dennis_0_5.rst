.. title: Dennis v0.5 released! New lint rules, new template linter, bunch of fixes, and now a service!
.. slug: dennis_0_5
.. date: 2014-08-24 22:22
.. tags: python, dev, dennis


What is it?
===========

`Dennis <https://github.com/willkg/dennis>`_ is a Python command line
utility (and library) for working with localization. It includes:

* a linter for finding problems in strings in ``.po`` files like invalid
  Python variable syntax which leads to exceptions

* a template linter for finding problems in strings in ``.pot`` files that
  make translator's lives difficult

* a statuser for seeing the high-level translation/error status of
  your ``.po`` files

* a translator for strings in your ``.po`` files to make development
  easier


v0.5 released!
==============

Since the last release announcement, there have been a handful of new lint
rules added:

* W301: Translation consists of just white space
* W302: The translation is the same as the original string
* W303: There are descrepancies in the HTML between the original string and
  the translated string

Additionally, there's a new template linter for your ``.pot`` files which
can catch things like:

* W500: Strings with variable names like ``o``, ``O``, ``0``, ``l``, ``1``
  which can be hard to read and are often replaced with a similar looking
  letter by the translator.
* W501: One-character variable names which don't give translators enough
  context about what's being translated.
* W502: Multiple unnamed variables which can't be reordered because
  the order the variables are expanded is specified outside of the
  string.


Dennis in action
================

Want to see Dennis in action, but don't want to install Dennis? I
threw it up as a service, though it's configured for `SUMO
<https://support.mozilla.org/>`_:
http://dennis-sumo.paas.allizom.org/

.. Note::

   I may change the URL and I might create a SUMO-agnostic version.
   If you're interested, let me know.


Where to go for more
====================

For more specifics on this release, see here:
http://dennis.readthedocs.org/en/latest/changelog.html#version-0-5-august-24th-2014

Documentation and quickstart here:
http://dennis.readthedocs.org/en/v0.5/

Source code and issue tracker here:
https://github.com/willkg/dennis

Source code and issue tracker for Denise (Dennis-as-a-service):
https://github.com/willkg/denise

3 out of 5 summer interns use Dennis to improve their posture while pranking
their mentors.
