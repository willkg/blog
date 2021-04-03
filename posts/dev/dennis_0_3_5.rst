.. title: Dennis v0.3.5 released!
.. slug: dennis_0_3_5
.. date: 2013-09-18
.. tags: python, dev, dennis


What is it?
===========

`Dennis <https://github.com/willkg/dennis>`_ is a Python command line
utility (and library) for working with localization. It includes:

* a translator for strings ``.po`` files

* a linter for finding problems in strings in ``.po`` files


v0.3.5 released!
================

0.3.4 fixed an issue with the linter so it skips fuzzy strings.

0.3.5 fixes the rules default for the linter so that it includes the
malformed lint rules. It also adds detection of formatting tokens like
``{0]`` where it doesn't end in a curly brace. This kicks up a
ValueError in Python:

>>> '{0]'.format(1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: unmatched '{' in format
>>>

If you're using Dennis---especially to detect errors in .po files
before you push them to production---you should upgrade.


Talk like a pirate day!
=======================

Tomorrow, September 19th, is Talk like a Pirate Day. Dennis can help
you celebrate with its built-in Pirate translator which works on .po
files, but also works on any input from command line arguments or
stdin.

Translate your HTML pages:

.. code:: shell

   (cat < "$1" | dennis-cmd translate --pipeline=html,pirate -) > "pirate_$1"


Translate all your git commit messages with this ``hooks/commit-msg``:

.. code:: shell

   #!/bin/bash

   # Pipe the contents of the commit message file through dennis to
   # a temp file, then copy it back.
   (cat < $1 | dennis-cmd translate - > $1.tmp) && mv $1.tmp $1

   # We always exit 0 even if the dennis-cmd fails. If the dennis-cmd
   # fails, you get your original commit message. No one likes it when
   # shenanigans break your stuff for realz.
   exit 0;


If you forget about this blog post, these two recipes are in the
`recipes section of the documentation
<http://dennis.readthedocs.org/en/latest/recipes.html>`_. If you have
other recipes, I'd love to hear about them!

Also, the Pirate! translator can always be improved. If there are
improvements you want to make, please `submit a pull request
<https://github.com/willkg/dennis/pulls>`_!
