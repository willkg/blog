.. title: Everett v0.8 released!
.. slug: everett_0_8
.. date: 2017-01-24 14:00
.. tags: python, dev, everett

What is it?
===========

`Everett <https://everett.readthedocs.io/>`_ is a Python configuration library.

Configuration with Everett:

* is composeable and flexible
* makes it easier to provide helpful error messages for users trying to configure your software
* can pull configuration from a variety of specified sources (environment, ini files, dict, write-your-own)
* supports parsing values (bool, int, lists of things, classes, write-your-own)
* supports key namespaces
* facilitates writing tests that change configuration values
* supports component architectures with auto-documentation of configuration with a Sphinx ``autoconfig`` directive
* works with whatever you're writing--command line tools, web sites, system daemons, etc

Everett is inspired by `python-decouple <https://github.com/henriquebastos/python-decouple>`_ and
`configman <https://configman.readthedocs.io/en/latest/>`_.


v0.8 released!
==============

As I sat down to write this, I discovered I'd never written about Everett
before. I wrote it initially as part of another project and then extracted it
and did a first release in August 2016.

Since then, I've been tinkering with how it works in relation to how it's used
and talking with peers to understand their thoughts on configuration.

At this stage, I like Everett and it's at a point where it's worth telling
others about and probably due for a 1.0 release.

This is v0.8. In this release, I spent some time polishing the ``autoconfig``
Sphinx directive to make it more flexible to use in your project documentation.
Instead of having configuration bits all over your project, you centralize it in
one place and then in your Sphinx docs, you have something like::

    .. autoconfig:: path.to.AppConfig


and it happily spits out the relevant configuration documentation. For example,
`here's Antenna's configuration documentation
<http://antenna.readthedocs.io/en/latest/configuration.html>`_.

It'd be nice if configuration variables showed up in the index. I'll mull over
that later.


Where to go for more
====================

For more specifics on this release, see here:
https://everett.readthedocs.io/en/latest/history.html#january-24th-2017

Documentation and quickstart here:
https://everett.readthedocs.org/en/v0.8/

Source code and issue tracker here:
https://github.com/willkg/everett
