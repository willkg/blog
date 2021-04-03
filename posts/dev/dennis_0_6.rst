.. title: Dennis v0.6 released! Line numbers, double vowels, better cli-fu, and better output!
.. slug: dennis_0_6
.. date: 2014-12-16 22:22
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


v0.6 released!
==============

Since v0.5, I've done the following:

* Rewrote the command line handling using `click <http://click.pocoo.org/3/>`_
  and added an exception handler.
* Merged the ``lint`` and ``linttemplate`` commands. Why should you care
  which file you're linting when the linter can figure it out for you?
* Added the whimsical double vowel transform.
* Added line numbers in the lint output. This will make it possible to
  find those pesky problematic strings in your ``.po``/``.pot`` files.
* Add a line reporter to the linter.

Getting pretty close to what I want for a 1.0, so I'm pretty excited
about this version.


Denise update
=============

I've updated Denise with the latest Dennis and moved it to a better
url. Lint your ``.po/.pot`` files via web service using
`<http://denise.paas.allizom.org/>`_.


Where to go for more
====================

For more specifics on this release, see here:
http://dennis.readthedocs.org/en/latest/changelog.html#version-0-6-december-16th-2014

Documentation and quickstart here:
http://dennis.readthedocs.org/en/v0.6/

Source code and issue tracker here:
https://github.com/willkg/dennis

Source code and issue tracker for Denise (Dennis-as-a-service):
https://github.com/willkg/denise

6 out of 8 employees said Dennis helps them complete 1.5 more
deliverables per quarter.
