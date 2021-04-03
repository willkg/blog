.. title: ElasticUtils: I'm stepping down and deprecating the project
.. slug: elasticutils.stepping_down
.. date: 2015-01-05 15:40
.. tags: mozilla, webdev, work, elasticutils, dev, python


What is^Wwas it?
================

`ElasticUtils <https://github.com/mozilla/elasticutils>`_ is^Wwas a Python
library for building and executing Elasticsearch searches.

See the `Quickstart <http://elasticutils.readthedocs.org/>`_ for more
details.

I'm stepping down as maintainer and ending the project.

.. TEASER_END
   

I'm taking my ball and going home
=================================

For the last few years, I've maintained ElasticUtils. It's a project I
picked up after Jeff, Dave and Erik left.

Since I picked it up, we've had 13 or so releases. We switched the
underlying library from pyes to pyelasticsearch and then to
elasticsearch-py. We added support for a variety of Elasticsearch
versions up to about 1.0. We overhauled the documentation. We
overhauled the test suite. We generalized it from just a Django
library into a library with a Django extension. We added
MappingTypes. We worked really hard to make it backwards compatible
from version to version. It's been a lot of work, but mostly in
spurts.

Since the beginning of the project in May 2011 (a year before I picked
up maintenance), we've had 33 people contribute patches. We've had
many more point out issues, ask questions on the #elasticutils IRC
channel, send me email about this and that.

That's a good run for an open source project. There are a bunch of
things I wish I had done differently when I was at the helm, but it's
a good run nonetheless.

The current state of things, however, is not great. ElasticUtils has a
ton of issues. Lots of technical debt accrued over the years, several
architectural decisions that turned out to suck and have obnoxious
consequences, lack of support for new features in Elasticsearch > 1.0,
etc. It'll take a lot of work to clean that up. Plus it's got a
CamelCase name and that's so passé.

At PyCon 2014, Rob, Jannis and I worked with Honza on the API for the
library that is now `elasticsearch-dsl-py <https://pypi.python.org/pypi/elasticsearch-dsl>`_.
This library has several of the things I like about ElasticUtils. It's
a project that's being supported by the Elasticsearch folks. It's got
momentum. It supports many of the Elasticsearch > 1.0 features. There
are several libraries that sit on top of elasticsearch-dsl-py as
Django shims now.

ElasticUtils is at a point where it's got a lot of problems and there
are good alternatives that are better supported.

Thus, this is an excellent time for me to step down as
maintainer. Going forward from today, I won't be doing any more
development or maintenance.

Further, I'm deprecating the project because no one should be using an
unmaintained broken project when there are better supported
alternatives. That way lies madness!

So, if you're using ElasticUtils, what do you do now?

ElasticUtils 0.10.2 has the things you need to bridge from
Elasticsearch 0.90 to 1.x. You could upgrade to that version and then
switch to elasticsearch-dsl-py or one of the Django shims.

On that note, so long ElasticUtils and thank you to everyone who's
helped on and used ElasticUtils over the years!
