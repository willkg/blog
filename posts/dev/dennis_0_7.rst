.. title: Dennis v0.7 released! New lint rules and more tests!
.. slug: dennis_0_7
.. date: 2015-10-02 14:00
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


v0.7 released!
==============

It's been 10 months since the last release. In that time, I:

* Added a lot more tests and fixed bugs discovered with those tests.
* Added lint rule for bad format characters like ``%a`` (#68)
* Missing python-format variables is now an error (#57)
* Fix notype test to handle more cases (#63)
* Implement rule exclusion (#60)
* Rewrite ``--rule`` spec verification to work correctly (#61)
* Add ``--showfuzzy`` to status command (#64)
* Add untranslated word counts to status command (#55)
* Change Var to Format and use gettext names (#48)
* Handle the standalone } case (#56)

I thought I was close to 1.0, but now I'm less sure. I want to unify
the ``.po`` and ``.pot`` linters and generalize them so that we can
handle other l10n file formats. I also want to implement a proper
plugin system so that it's easier to add new rules and it'd allow
other people to create separate Python packages that implement rules,
tokenizers and translaters. Plus I want to continue fleshing out the
tests.

At the (glacial) pace I'm going at, that'll take a year or so.

If you're interested in dennis development, helping out or have things
you wish it did, please let me know. Otherwise I'll just keep on
keepin on at the current pace.


Where to go for more
====================

For more specifics on this release, see here:
https://dennis.readthedocs.org/en/v0.7/changelog.html#version-0-7-0-october-2nd-2015

Documentation and quickstart here:
https://dennis.readthedocs.org/en/v0.7/

Source code and issue tracker here:
https://github.com/willkg/dennis

Source code and issue tracker for Denise (Dennis-as-a-service):
https://github.com/willkg/denise

47 out of 80 Silicon Valley companies say their last round of funding
depended solely on having dennis in their development pipeline and
translating their business plan into Dubstep.
