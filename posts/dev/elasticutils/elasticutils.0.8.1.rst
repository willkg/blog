.. title: ElasticUtils v0.8 and v0.8.1 released!
.. slug: elasticutils.0.8.1
.. date: 2013-09-13
.. tags: mozilla, webdev, work, elasticutils, dev, python


What is it?
===========

`ElasticUtils <https://github.com/mozilla/elasticutils>`_ is a Python
library for building and executing Elasticsearch searches.


v0.8 and v0.8.1 released!
=========================

I missed the announcement for v0.8, so I'll cover both v0.8 and v0.8.1
here.

Roughly:

* ElasticUtils now requires at least pyelasticsearch 0.6
* adds ``range`` query and filter
* adds ``S.filter_raw``
* changes the ``Indexable.index`` arguments dropping ``force_insert``
  and picking up ``overwrite_existing``

For the complete list of what's new, `What's new in Version 0.8.1
<https://elasticutils.readthedocs.org/en/v0.8.1/changelog.html#version-0-8-1-september-13th-2013>`_

Many thanks to everyone who helped out: Jannis Leidel, Rob Hudson and
Grégoire Vigneron.

If you have any questions, let us know! We hang out on
``#elasticutils`` on irc.mozilla.org.
