.. title: Dennis v0.4 released! Tweaks to Python 3 support, overhauled linter, string-by-string lint rules ignoring
.. slug: dennis_0_4
.. date: 2014-05-01 12:00
.. tags: python, dev, dennis


What is it?
===========

`Dennis <https://github.com/willkg/dennis>`_ is a Python command line
utility (and library) for working with localization. It includes:

* a linter for finding problems in strings in ``.po`` files like invalid
  Python variable syntax which leads to exceptions

* a statuser for seeing the high-level translation/error status of
  your ``.po`` files

* a translator for strings in your ``.po`` files to make development
  easier


v0.4 released!
==============

v0.4 sports an overhauled linter. Instead of two rules ("malformed"
and whatever the other one was), it now has a bunch of much smaller
and more specific rules! Also, I renamed the rules so they are all
numbered!

See the table of error/warning rules and their numbers here:
http://dennis.readthedocs.org/en/v0.4/linting.html#warnings-and-errors

Additionally, dennis hits false positives for a variety of reasons. If
you're doing a "keep the errors out of production!" kind of thing,
then false positives can prevent locale files from making it. That
sucks!

To alleviate this, dennis now allows you to tell it what to ignore in
the extracted comments. What's an extracted comment? It's a comment in
the .po file that starts with ``#.``. You can specify the extracted
comments with "context" or similar mechanisms depending on how you're
extracting strings. You can tell dennis to skip specific rules or skip
all the rules on a string-by-string basis.

Ignore everything::

    #. dennis-ignore: *
    msgid "German makes up 10% of our visitor base"
    msgstr "A német a látogatóbázisunk 10%-át teszi ki"


Ignore specific rules (comma-separated)::

    #. dennis-ignore: E101,E102,E103
    msgid "German makes up 10% of our visitor base"
    msgstr "A német a látogatóbázisunk 10%-át teszi ki"


Ignore everything, but note the beginning of the line is ignored by
dennis so you can tell localizers to ignore the ignore thing::

    #. localizers--ignore this comment. dennis-ignore: *
    msgid "German makes up 10% of our visitor base"
    msgstr "A német a látogatóbázisunk 10%-át teszi ki"


I also tweaked some of the Python 3 support code because it looked at
me funny.

Also, universal wheel!

For more specifics on this release, see here:
http://dennis.readthedocs.org/en/v0.4/changelog.html#version-0-4-may-1st-2014

Documentation and quickstart here:
http://dennis.readthedocs.org/en/v0.4/

Source code and issue tracker here:
https://github.com/willkg/dennis

2 out of 10 people saw the Pirate translation on
`The Web We Want (Mozilla) <https://webwewant.mozilla.org/xx/>`_. Arrr!
