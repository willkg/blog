.. title: Adding Persona authentication to richard
.. slug: adding_browserid
.. date: 2013-03-19
.. tags: dev, persona, python, dev, richard, pyvideo


tl;dr
=====

This is a post covering my first time experience with integrating
Persona authentication into my Django project named `richard
<https://github.com/willkg/richard>`_. I briefly cover why I did it,
what I used, and list the commits I did the work in as an example of
how it can be done. I hope this helps others implement it on their
sites..


why
===

A month ago, I added Persona authentication support to richard.  This
allowed me to use Persona authentication for `pyvideo.org
<http://pyvideo.org/>`_. I did this for several reasons:

1. I wanted to try it out and see how well it worked on a small Django
   site (tl;dr works great---I'll use this on all my sites)

2. I wanted people to authenticate with an email-based identity rather
   than a social network based identity

3. I wanted to allow people to create accounts on pyvideo.org, but
   didn't want to deal with the responsibility of protecting things
   like passwords

So that's where I'm coming from.


how
===

I used `django-browserid
<https://github.com/mozilla/django-browserid>`_ which gives you some
JavaScript and a few template tags that make it easy to incorporate
Persona authentication into a Django app.

It took about 15 minutes to get it working. I've made some minor edits
to the code since then and updated to v0.8 of django-browserid. All
told, I think I've spent a couple of hours on Persona
implementation.

In the process of doing that work, I hit a few minor issues, created
some pull requests, helped with other pull requests and became one of
the maintainers. Yay!

Here are the commits I did the work in. I figured the diffs might help
you implement similar things on your sites:

* Add persona authentication:
  https://github.com/willkg/richard/commit/f917409
* Update django-browserid to 0.8:
  https://github.com/willkg/richard/commit/a69a74f
* Update to master tip to fix login failure problem I had:
  https://github.com/willkg/richard/commit/be73b43


That last commit updates to django-browserid master tip to pick up a
fix to login failures if ``BROWSERID_CREATE_USER`` is False. That fix
will be released in v0.8.1 soon.


further reading
===============

The `Mozilla Persona site <http://www.mozilla.org/en-US/persona/>`_
helps understand why it exists and has a Developer FAQ.

The `django-browserid docs <http://django-browserid.rtfd.org/>`_ are
pretty good and walk through setting it up, advanced usage, and
troubleshooting. I encourage you to read through them in full---it'll
give you a better understanding of the pieces.

Dan Callahan did a talk at `PyCon US 2013
<http://pyvideo.org/category/33/pycon-us-2013>`_ on Persona. That's
worth watching. It covers why Mozilla built it, how it works, and why
it's important that it works that way. He also demos integrating it
into sites and talks about using Persona authentication alongside
other authentication methods.

If you're interested in adding Persona authentication to your Django
site and need help, let me know.
