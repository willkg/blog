.. title: Everett v1.0.3 released!
.. slug: everett_1_0_3
.. date: 2020-10-28 09:00
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


v1.0.3 released!
================

This is a minor maintenance update that fixes a couple of minor bugs, addresses
a Sphinx deprecation issue, drops support for Python 3.4 and 3.5, and adds
support for Python 3.8 and 3.9 (largely adding those environments to the test
suite).


Why you should take a look at Everett
=====================================

At Mozilla, I'm using Everett for a variety of projects: Mozilla symbols
server, Mozilla crash ingestion pipeline, and some other tooling. We use it in
a bunch of other places at Mozilla, too.

Everett makes it easy to:

1. deal with different configurations between local development and
   server environments
2. test different configuration values
3. document configuration options

First-class docs. First-class configuration error help. First-class testing.
This is why I created Everett.

If this sounds useful to you, take it for a spin. It's a drop-in replacement
for python-decouple and ``os.environ.get('CONFIGVAR', 'default_value')`` style
of configuration so it's easy to test out.

Enjoy!


Where to go for more
====================

For more specifics on this release, see here:
https://everett.readthedocs.io/en/latest/history.html#october-28th-2020

Documentation and quickstart here:
https://everett.readthedocs.io/

Source code and issue tracker here:
https://github.com/willkg/everett
