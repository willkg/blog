.. title: Everett v1.0.0 released!
.. slug: everett_1_0_0
.. date: 2019-01-07 10:00
.. tags: python, dev, everett

What is it?
===========

`Everett <https://everett.readthedocs.io/>`_ is a configuration library for Python
apps.

Goals of Everett:

1. flexible configuration from multiple configured environments
2. easy testing with configuration
3. easy documentation of configuration for users

From that, Everett has the following features:

* is composeable and flexible
* makes it easier to provide helpful error messages for users trying to
  configure your software
* supports auto-documentation of configuration with a Sphinx
  ``autocomponent`` directive
* has an API for testing configuration variations in your tests
* can pull configuration from a variety of specified sources (environment,
  INI files, YAML files, dict, write-your-own)
* supports parsing values (bool, int, lists of things, classes,
  write-your-own)
* supports key namespaces
* supports component architectures
* works with whatever you're writing--command line tools, web sites, system
  daemons, etc


v1.0.0 released!
================

This release fixes many sharp edges, adds a YAML configuration environment, and
fixes Everett so that it has no dependencies unless you want to use YAML or INI.

It also drops support for Python 2.7--Everett no longer supports Python 2.


Why you should take a look at Everett
=====================================

At Mozilla, I'm using Everett for `Antenna
<https://github.com/mozilla/antenna>`_ which is the edge collector for the
crash ingestion pipeline for Mozilla products including Firefox and Fennec.
It's been in production for a little under a year now and doing super.
Using Everett makes it much easier to:

1. deal with different configurations between local development and
   server environments
2. test different configuration values
3. document configuration options

It's also used in a few other places and I plan to use it for the rest
of the components in the crash ingestion pipeline.

First-class docs. First-class configuration error help. First-class testing.
This is why I created Everett.

If this sounds useful to you, take it for a spin. It's almost a drop-in
replacement for python-decouple and ``os.environ.get('CONFIGVAR',
'default_value')`` style of configuration.

Enjoy!


Thank you!
==========

Thank you to Paul Jimenez who helped fixing issues and provided
thoughtful insight on API ergonomics!


Where to go for more
====================

For more specifics on this release, see here:
https://everett.readthedocs.io/en/latest/history.html#january-7th-2019

Documentation and quickstart here:
https://everett.readthedocs.io/en/latest/

Source code and issue tracker here:
https://github.com/willkg/everett
