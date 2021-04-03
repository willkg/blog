.. title: Markus v3.0.0 released! Better metrics API for Python projects.
.. slug: markus_3_0_0
.. date: 2021-02-05 10:00
.. tags: python, dev, markus, metrics

What is it?
===========

`Markus <https://markus.readthedocs.io/>`_ is a Python library for generating
metrics.

Markus makes it easier to generate metrics in your program by:

* providing multiple backends (Datadog statsd, statsd, logging, logging roll-up,
  and so on) for sending metrics data to different places

* sending metrics to multiple backends at the same time

* providing testing helpers for easy verification of metrics generation

* providing a decoupled architecture making it easier to write code to generate
  metrics without having to worry about making sure creating and configuring a
  metrics client has been done--similar to the Python logging module in this
  way

We use it at Mozilla on many projects.


v3.0.0 released!
================

I released v3.0.0 just now. Changes:

**Features**

* Added support for Python 3.9 (#79). Thank you, Brady!

* Changed ``assert_*`` helper methods on ``markus.testing.MetricsMock``
  to print the records to stdout if the assertion fails. This can save some
  time debugging failing tests. (#74)

**Backwards incompatible changes**

* Dropped support for Python 3.5 (#78). Thank you, Brady!

* ``markus.testing.MetricsMock.get_records`` and
  ``markus.testing.MetricsMock.filter_records`` return
  ``markus.main.MetricsRecord`` instances now.

  This might require you to rewrite/update tests that use the ``MetricsMock``.


Where to go for more
====================

Changes for this release:
https://markus.readthedocs.io/en/latest/history.html#february-5th-2021

Documentation and quickstart here:
https://markus.readthedocs.io/en/latest/index.html

Source code and issue tracker here:
https://github.com/willkg/markus/

Let me know how this helps you!
