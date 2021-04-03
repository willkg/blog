.. title: ElasticUtils v0.9 released!
.. slug: elasticutils.0.9
.. date: 2014-04-03 16:00
.. tags: mozilla, webdev, work, elasticutils, dev, python


What is it?
===========

`ElasticUtils <https://github.com/mozilla/elasticutils>`_ is a Python
library for building and executing Elasticsearch searches.

See the `Quickstart <http://elasticutils.readthedocs.org/>`_ for more
details.


v0.9 released!
==============

This is a big release, but there are some compromises in it that I'm
not wildly excited about. Things like Elasticsearch 1.0 support didn't
make the cut. I'm really sorry about that---we're working on it.

This release has a lot of changes in it. Roughly:

* dropped pyelasticsearch for elasticsearch-py (Thank you Honza!)
* fixed ``S.all()`` so it does what Django does which should let you
  use an ``S`` in the place of a ``QuerySet`` in some cases
* new ``FacetResult`` class (Thank you James!)
* ``S.facet()`` can take a size keyword
* cleaned up ``ESTestCase``
* ``SearchResults`` now has facet data in the ``facets`` property
* etc.


For the complete list of what's new, `What's new in Version 0.9
<http://elasticutils.readthedocs.org/en/latest/changelog.html#version-0-9-april-3rd-2014>`_.

Many thanks to everyone who helped out:
Alexey Kotlyarov,
David Lundgren,
Honza Král,
James Reynolds,
Jannis Leidel,
Juan Ignacio Catalano,
Kevin Stone,
Mathieu Pillard,
Mihnea Dobrescu-Balaur,
nearlyfreeapps,
Ricky Cook,
Rob Hudson,
William Tisäter and
Will Kahn-Greene.


We're going to be sprinting on ElasticUtils 0.10 at PyCon US in
Montreal mid April. If you're interested, come find me!

If you have any questions, let us know! We hang out on
``#elasticutils`` on irc.mozilla.org.
