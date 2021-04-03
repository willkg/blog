.. title: Everett v0.9 released and why you should use Everett
.. slug: everett_0_9
.. date: 2017-04-07 10:00
.. tags: python, dev, everett

What is it?
===========

`Everett <https://everett.readthedocs.io/>`_ is a Python configuration library.

Configuration with Everett:

* is composeable and flexible
* makes it easier to provide helpful error messages for users trying to configure your software
* supports auto-documentation of configuration with a Sphinx ``autocomponent`` directive
* supports easy testing with configuration override
* can pull configuration from a variety of specified sources (environment, ini files, dict, write-your-own)
* supports parsing values (bool, int, lists of things, classes, write-your-own)
* supports key namespaces
* supports component architectures
* works with whatever you're writing--command line tools, web sites, system daemons, etc

Everett is inspired by `python-decouple <https://github.com/henriquebastos/python-decouple>`_ and
`configman <https://configman.readthedocs.io/en/latest/>`_.


v0.9 released!
==============

This release focused on overhauling the Sphinx extension. It now:

* has an Everett domain
* supports roles
* indexes Everett components and options
* looks a lot better

This was the last big thing I wanted to do before doing a 1.0 release. I
consider Everett 0.9 to be a solid beta. Next release will be a 1.0.


Why you should take a look at Everett
=====================================

At Mozilla, I'm using Everett 0.9 for `Antenna
<https://github.com/mozilla/antenna>`_ which is running in our -stage
environment and will go to -prod very soon. Antenna is the edge of the crash
ingestion pipeline for Mozilla Firefox.

When writing Antenna, I started out with python-decouple, but I didn't like the
way python-decouple dealt with configuration errors (it's pretty hands-off) and
I really wanted to automatically generate documentation from my configuration
code. Why write the same stuff twice especially where it's a critical part of
setting Antenna up and the part everyone will trip over first?

Here's the configuration documentation for Antenna:

http://antenna.readthedocs.io/en/latest/configuration.html#application

Here's the index which makes it easy to find things by component or by option
(in this case, environment variables):

http://antenna.readthedocs.io/en/latest/genindex.html

When you configure Antenna incorrectly, it spits out an error message like this::

  1  <traceback omitted, but it'd be here>
  2  everett.InvalidValueError: ValueError: invalid literal for int() with base 10: 'foo'
  3  namespace=None key=statsd_port requires a value parseable by int
  4  Port for the statsd server
  5  For configuration help, see https://antenna.readthedocs.io/en/latest/configuration.html

So what's here?:

* Block 1 is the traceback so you can trace the code if you need to.
* Line 2 is the exception type and message
* Line 3 tells you the namespace, key, and parser used
* Line 4 is the documentation for that specific configuration option
* Line 5 is the "see also" documentation for the component with that configuration option

Is it beautiful? No. [1]_ But it gives you enough information to know what the
problem is and where to go for more information.

Further, in Python 3, Everett will always raise a subclass of
``ConfigurationError`` so if you don't like the output, you can tailor it to
your project's needs. [2]_

First-class docs. First-class configuration error help. First-class testing.
This is why I created Everett.

If this sounds useful to you, take it for a spin. It's almost a drop-in
replacement for python-decouple [3]_ and ``os.environ.get('CONFIGVAR',
'default_value')`` style of configuration.

Enjoy!

.. [1] I would love some help here--making that information easier to parse
       would be great for a 1.0 release.

.. [2] Python 2 doesn't support exception chaining and I didn't want to stomp on
       the original exception thrown, so in Python 2, Everett doesn't wrap
       exceptions.

.. [3] python-decouple is a great project and does a good job at what it was
       built to do. I don't mean to demean it in any way. I have additional
       requirements that python-decouple doesn't do well and that's where I'm
       coming from.


Where to go for more
====================

For more specifics on this release, see here:
http://everett.readthedocs.io/en/latest/history.html#april-7th-2017

Documentation and quickstart here:
https://everett.readthedocs.org/en/v0.9/

Source code and issue tracker here:
https://github.com/willkg/everett
