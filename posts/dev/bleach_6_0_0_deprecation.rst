.. title: Bleach 6.0.0 release and deprecation
.. slug: bleach_6_0_0_deprecation
.. date: 2023-01-23 11:55:31 UTC-05:00
.. tags: python, dev, bleach, mozilla, story
.. type: text

What is it?
===========

`Bleach <https://bleach.readthedocs.io/>`_ is a Python library for sanitizing
and linkifying text from untrusted sources for safe usage in HTML.


Bleach v6.0.0 released!
=======================

Bleach 6.0.0 cleans up some issues in linkify and with the way it uses html5lib
so it's easier to reason about. It also adds support for Python 3.11 and cleans
up the project infrastructure.

There are several backwards-incompatible changes, hence the 6.0.0 version.

https://bleach.readthedocs.io/en/latest/changes.html#version-6-0-0-january-23rd-2023

I did some rough testing with a corpus of Standup messages data and it looks
like ``bleach.clean`` is slightly faster with 6.0.0 than 5.0.0.

Using Python 3.10.9:

* 5.0.0: bleach.clean on 58,630 items 10x: minimum 2.793s
* 6.0.0: bleach.clean on 58,630 items 10x: minimum 2.304s

The other big change 6.0.0 brings with it is that it's now deprecated.


Bleach is deprecated
====================

Bleach sits on top of `html5lib <https://github.com/html5lib/html5lib-python>`__
which is not actively maintained. It is increasingly difficult to maintain
Bleach in that context and I think it's nuts to build a security library on top
of a library that's not in active development.

Over the years, we've talked about other options:

1. find another library to switch to
2. take over html5lib development
3. fork html5lib and vendor and maintain our fork
4. write a new HTML parser
5. etc

With the exception of option 1, they greatly increase the scope of the work for
Bleach. They all feel exhausting to me.

Given that, I think Bleach has run its course and this journey is over.


What happens now?
=================

Possibilities:

1. Pass it to someone else?

   No, I won't be passing Bleach to someone else to maintain. Bleach is a
   security-related library, so making a mistake when passing it to someone
   else would be a mess. I'm not going to do that.

2. Switch to an alternative?

   I'm not aware of any alternatives to Bleach. I don't plan to work on
   coordinating the migration for everyone from Bleach to something else.

3. Oh my goodness--you're leaving us with nothing?

   Sort of.

I'm going to continue doing minimal maintenance:

1. security updates
2. support for new Python versions
3. fixes for egregious bugs (begrudgingly)

I'll do that for at least a year. At some point, I'll stop doing that, too.

I think that gives the world enough time for either something to take Bleach's
place, or for the `sanitizing web api
<https://caniuse.com/mdn-api_sanitizer>`__ to kick in, or for everyone to come
to the consensus that they never really needed Bleach in the first place.

.. thumbnail:: /images/bleach_deprecation.jpg

   Bleach. Tired. At the end of its journey.


Where to go for more
====================

For more specifics on this release, see here:
https://bleach.readthedocs.io/en/latest/changes.html#version-6-0-0-january-23rd-2023

Documentation and quickstart here:
https://bleach.readthedocs.io/en/latest/

Source code and issue tracker here:
https://github.com/mozilla/bleach
