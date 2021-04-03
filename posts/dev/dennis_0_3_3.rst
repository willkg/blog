.. title: Dennis v0.3.3 released!
.. slug: dennis_0_3_3
.. date: 2013-07-29 10:44
.. tags: python, dev, dennis


What is it?
===========

`Dennis <https://github.com/willkg/dennis>`_ is a Python command line
utility (and library) for working with localization. It includes:

* a translator for strings ``.po`` files

* a linter for finding problems in strings in ``.po`` files


v0.3.3 released!
================

This is the first blog-post-announced release. I think Dennis is good
enough for wider use. I've been using it for development work on both
`kitsune <https://github.com/mozilla/kitsune>`_ (which drives `Support
<https://support.mozilla.org>`_) and `fjord
<https://github.com/mozilla/fjord>`_ (which drives `Input
<https://input.mozilla.org>`_ with great success.


Why Dennis?
===========

It fills two basic needs I had:

1. translate ``.po`` files so I can find problems during development
   related to localized strings, layout issues, unicode support, etc

2. lint translated ``.po`` files so that errors in translated strings
   don't make it to production where they cause fires, make users
   angry and make me very sad and tired

There's another project called `Translate Toolkit
<http://docs.translatehouse.org/projects/translate-toolkit/en/latest/index.html>`_
that you could use for item 1, but it doesn't have Pirate! and I like
my pipeline architecture since it's more "pluggable" (whatever that
means). Plus it didn't have a linter that covered my specific issues
nor does it return a non-zero exit status so I can't use it for
selective compiling.

Therefore I decided to write my own tool to meet my needs.


The ultra-basics
================

Install
-------

::

    $ pip install dennis
    $ pip install blessings  # Optional for prettier output


Linting
-------

Lint a single ``.po`` file for problems including mismatched/malformed
Python variables in translated strings::

    $ dennis-cmd lint locale/fr/LC_MESSAGES/messages.po


Produces output like this::

    (dennis) saturn ~/mozilla/fjord> dennis-cmd lint locale/fr/LC_MES
    SAGES/messages.po
    dennis-cmd version 0.3.4.dev
    >>> Working on: /home/willkg/mozilla/fjord/locale/fr/LC_MESSAGES/
    messages.po
    Error: mismatched: invalid variables: {count}
    msgid: Most Recent Message
    msgstr[0]: Les {count} derniers messages

    Error: mismatched: invalid variables: {count}
    msgid: Most Recent Message
    msgid_plural: Last %(count)s Messages
    msgstr[1]: Les {count} derniers messages

    Warning: mismatched: missing variables: %(count)s
    msgid: Most Recent Message
    msgid_plural: Last %(count)s Messages
    msgstr[1]: Les {count} derniers messages

    Error: mismatched: invalid variables: {count}
    msgid: {0} similar messages
    msgstr: Les {count} derniers messages

    Warning: mismatched: missing variables: {0}
    msgid: {0} similar messages
    msgstr: Les {count} derniers messages

    Totals
      Warnings:     2
      Errors:       3


If you have `blessings <https://pypi.python.org/pypi/blessings/>`_
installed, it'll colorize that output.


You can also lint a directory structure of ``.po`` files::

    $ dennis-cmd lint --errorsonly locale/


We use this to compile only the error-free ``.po`` files to ``.mo`` files and
tell us which ``.po`` files have problems so we can fix them. This prevents
HTTP 500 errors and inaccessible pages due to maltranslated strings on our
sites.


Translating
-----------

You can translate a ``.po`` file in place into Pirate! to help find
l10n issues in your code::

    $ dennis-cmd translate --pipeline=html,pirate \
        locale/xx/LC_MESSAGES/messages.po


This takes into account that the strings have HTML in them that should
be ignored when translating. It uses a pipeline architecture where the
output of one transform is fed as input to the next, so you can string
them along and get shouty extra-pirate with anglequotes::

    $ dennis-cmd translate --pipeline=html,pirate,pirate,shouty,anglequote \
        locale/xx/LC_MESSAGES/messages.po


Summary
=======

That's the gist of it. In the `Dennis documentation
<https://dennis.rtfd.org>`_ is a `list of Dennis recipes
<http://dennis.readthedocs.org/en/latest/recipes.html>`_ covering
linting, translating, etc.

Yay for Dennis!
