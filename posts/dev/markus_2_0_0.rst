.. title: Markus v2.0.0 released! Better metrics API for Python projects.
.. slug: markus_2_0_0
.. date: 2019-09-19 9:00
.. tags: python, dev, markus, metrics

What is it?
===========

`Markus <https://markus.readthedocs.io/>`_ is a Python library for generating
metrics.

Markus makes it easier to generate metrics in your program by:

* providing multiple backends (Datadog statsd, statsd, logging, logging roll-up,
  and so on) for sending metrics data to different places

* sending metrics to multiple backends at the same time

* providing a testing framework for easy metrics generation testing

* providing a decoupled architecture making it easier to write code to generate
  metrics without having to worry about making sure creating and configuring a
  metrics client has been done--similar to the Python logging
  module in this way

We use it at Mozilla on many projects.


v2.0.0 released!
================

I released v2.0.0 just now. Changes:

**Features**

* Use ``time.perf_counter()`` if available. Thank you, Mike! (#34)
* Support Python 3.7 officially.
* Add filters for adjusting and dropping metrics getting emitted.
  See documentation for more details. (#40)

**Backwards incompatible changes**

* ``tags`` now defaults to ``[]`` instead of ``None`` which may affect some
  expected test output.
* Adjust internals to run ``.emit()`` on backends. If you wrote your own
  backend, you may need to adjust it.
* Drop support for Python 3.4. (#39)
* Drop support for Python 2.7.
  
  If you're still using Python 2.7, you'll need to pin to ``<2.0.0``. (#42)

**Bug fixes**

* Document feature support in backends. (#47)
* Fix ``MetricsMock.has_record()`` example. Thank you, John!


Where to go for more
====================

Changes for this release:
https://markus.readthedocs.io/en/latest/history.html#september-19th-2019

Documentation and quickstart here:
https://markus.readthedocs.io/en/latest/index.html

Source code and issue tracker here:
https://github.com/willkg/markus

Let me know whether this helps you!
