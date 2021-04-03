.. title: Markus v1.0 released! Better metrics API for Python projects.
.. slug: markus_1_0
.. date: 2017-10-30 9:00
.. tags: python, dev, markus, metrics

What is it?
===========

`Markus <https://markus.readthedocs.io/>`_ is a Python library for generating
metrics.

Markus makes it easier to generate metrics in your program by:

* providing multiple backends (Datadog statsd, statsd, logging, logging roll-up,
  and so on) for sending data to different places

* sending metrics to multiple backends at the same time

* providing a testing framework for easy testing

* providing a decoupled architecture making it easier to write code to generate
  metrics without having to worry about making sure creating and configuring a
  metrics client has been done--similar to the Python logging
  module in this way

I use it at Mozilla in the collector of our crash ingestion pipeline. Peter used
it to build our symbols lookup server, too.


v1.0 released!
==============

This is the v1.0 release. I pushed out v0.2 back in April 2017. We've been using
it in Antenna (the collector of the Firefox crash ingestion pipeline) since
then. At this point, I think the API is sound and it's being used in production,
ergo it's production-ready.

This release also adds Python 2.7 support.


Why you should take a look at Markus
====================================

Markus does three things that make generating metrics a lot easier.

**First, it separates creating and configuring the metrics backends from
generating metrics.**

Let's create a metrics client that sends data nowhere:

.. code:: python

   import markus

   markus.configure()


That's not wildly helpful, but it works and it's 2 lines.

Say we're doing development on a laptop on a speeding train and want to spit out
metrics to the Python logging module so we can see what's being generated. We
can do this:

.. code:: python

   import markus

   markus.configure(
       backends=[
           {
               'class': 'markus.backends.logging.LoggingMetrics'
           }
       ]
   )


That will spit out lines to Python logging. Now I can see metrics getting
generated while I'm testing my code.

I'm ready to put my code in production, so let's add a statsd backend, too:

.. code:: python

   import markus

   markus.configure(
       backends=[
           {
               # Log metrics to the logs
               'class': 'markus.backends.logging.LoggingMetrics',
           },
           {
               # Log metrics to statsd
               'class': 'markus.backends.statsd.StatsdMetrics',
               'options': {
                   'statsd_host': 'statsd.example.com',
                   'statsd_port': 8125,
                   'statsd_prefix': '',
               }
           }
       ]
   )


That's it. Tada!

Markus can support any number of backends. You can send data to multiple statsd
servers. You can use the ``LoggingRollupBackend`` which will generate statistics
every *flush_interval* of count, current, min, and max for incr stats and count,
min, average, median, 95%, and max for timing/histogram stats for metrics data.

If Markus doesn't have the backends you need, writing your own metrics backend
is straight-forward.

For more details, see `the usage documentation
<http://markus.readthedocs.io/en/latest/usage.html>`_ and `the backends
documentation <http://markus.readthedocs.io/en/latest/backends.html>`_.

**Second, writing code to generate metrics is straight-forward and easy to
do.**

Much like the Python logging module, you add ``import markus`` at the top of the
Python module and get a metrics interface. The interface can be module-level or
in a class. It doesn't matter.

Here's a module-level metrics example:

.. code:: python

   import markus

   metrics = markus.get_metrics(__name__)


Then you use it:

.. code:: python

   @metrics.timer_decorator('chopping_vegetables')
   def some_long_function(vegetable):
       for veg in vegetable:
           chop_vegetable()
           metrics.incr('vegetable', 1)


That's it. No bootstrapping problems, nice handling of metrics key prefixes,
decorators, context managers, and so on. You can use multiple metrics
interfaces in the same file. You can pass them around. You can reconfigure
the metrics client and backends dynamically while your program is running.

For more details, see `the metrics overview documentation
<http://markus.readthedocs.io/en/latest/metricsoverview.html>`_.

**Third, testing metrics generation is easy to do.**

Markus provides a ``MetricsMock`` to make testing easier:

.. code:: python

   import markus
   from markus.testing import MetricsMock


   def test_something():
       with MetricsMock() as mm:
           # ... Do things that might publish metrics

           # This helps you debug and write your test
           mm.print_records()

           # Make assertions on metrics published
           assert mm.has_metric(markus.INCR, 'some.key', {'value': 1})


I use it with pytest on my projects, but it is testing-system agnostic.

For more details, see `the testing documentation
<http://markus.readthedocs.io/en/latest/testing.html>`_.


Why not use statsd directly?
============================

You can definitely use statsd/dogstatsd libraries directly, but using Markus is
a lot easier.

With Markus you don't have to worry about the order in which you
create/configure the statsd client versus using the statsd client. You don't
have to pass around the statsd client. It's a lot easier to use in Dango and
Flask where bootstrapping the app and passing things around is tricky sometimes.

With Markus you get to degrade to sending metrics data to the Python logging
library which helps surface issues in development. I've had a few occasions when
I thought I wrote code to send data, but it turns out I hadn't or that I had
messed up the keys or tags.

With Markus you get a testing mock which lets you write tests guaranteeing that
your code is generating metrics the way you're expecting.

If you go with using the statsd/dogstatsd libraries directly, that's fine, but
you'll probably want to write some/most of these things yourself.


Where to go for more
====================

For more specifics on this release, see here:
https://markus.readthedocs.io/en/latest/history.html#october-30th-2017

Documentation and quickstart here:
https://markus.readthedocs.io/en/latest/index.html

Source code and issue tracker here:
https://github.com/willkg/markus

Let me know whether this helps you!
