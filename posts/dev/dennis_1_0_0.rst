.. title: Dennis v1.0.0 released! Retrospective! Handing it off!
.. slug: dennis_1_0_0
.. date: 2022-06-10 12:00
.. tags: python, dev, dennis

What is it?
===========

`Dennis <https://github.com/mozilla/dennis>`_ is a Python command line utility
(and library) for working with localization. It includes:

* a linter for finding problems in strings in ``.po`` files like invalid Python
  variable syntax which leads to exceptions

* a template linter for finding problems in strings in ``.pot`` files that make
  translator's lives difficult

* a statuser for seeing the high-level translation/error status of your ``.po``
  files

* a translator for strings in your ``.po`` files to make development easier


v1.0.0 released!
================

It's been 5 years since I released Dennis v0.9. That's a long time.

This brings several minor things and clean up. Also, I transferred the
repository from "willkg" to "mozilla" in GitHub.

* b38a678 Drop Python 3.5/3.6; add Python 3.9/3.10 (#122, #123, #124, #125)
* b6d34d7 Redo tarrminal printin' and colorr (#71)

  There's an additional backwards-incompatible change here in which we drop
  the ``--color`` and ``--no-color`` arguments from ``dennis-cmd lint``.
* 658f951 Document dubstep (#74)
* adb4ae1 Rework CI so it uses a matrix
* transfer project from willkg to mozilla for ongoing maintenance and support


Retrospective
=============

I worked on Dennis for 9 years.

It was incredibly helpful! It eliminated an entire class of bugs we were
plagued with for critical Mozilla sites like `AMO
<https://addons.mozilla.org/>`_, `MDN <https://developer.mozilla.org>`_, `SUMO
<https://support.mozilla.org/>`_, Input [#]_, and others. It did it in a way that
supported and was respectful of our localization community.

It was pretty fun! The translation transforms are incredibly helpful for fixing
layout issues. Some of them also produce hilarious results:

.. [#] Input has gone to the happy hunting ground in the sky.


.. thumbnail:: /images/sumo_dubstep1.png

   SUMO in dubstep.


.. thumbnail:: /images/sumo-pirate.png

   SUMO in Pirate.


.. thumbnail:: /images/sumo_zombie1.png

   SUMO in Zombie.


There were a variety of `dennis recipes
<https://dennis.readthedocs.io/en/latest/recipes.html>`_ including using it in
a commit hook to translate commit messages.
https://github.com/mozilla/dennis/commits/main

I enjoyed writing silly things at the bottom of all the release blog posts.

I learned a lot about gettext, localization, and languages! Learning about the
nuances of plurals was fascinating.

The code isn't great. I wish I had redone the tokenization pipeline. I wish I
had gotten around to adding support for other gettext variable formats.

Regardless, this project had a significant impact on Mozilla sites which I
covered briefly in my :doc:`dennis_retrospective_2013`.


Handing it off
==============

It's been 6 years since I worked on sites that have localization, so I haven't
really used Dennis in a long time and I'm no longer a stakeholder for it.

I need to reduce my maintenance load, so I looked into whether to end this
project altogether. Several Mozilla projects still use it for linting PO files
for deploys, so I decided not to end the project, but instead hand it off.

Welcome `@diox <https://github.com/diox>`_ and `@akatsoulas
<https://github.com/akatsoulas>`_ who are picking it up!


Where to go for more
====================

For more specifics on this release, see here:
https://dennis.readthedocs.io/en/latest/changelog.html#version-1-0-0-june-10th-2022

Documentation and quickstart here:
https://dennis.readthedocs.io/en/latest/

Source code and issue tracker here:
https://github.com/mozilla/dennis

39 of 7,952,991,938 people were aware that Dennis existed but tens--nay,
hundreds!--of millions were affected by it.
