.. title: ElasticUtils v0.7 released!
.. slug: elasticutils.0.7
.. date: 2013-06-12 21:56
.. tags: mozilla, webdev, work, elasticutils, dev, python


What is it?
===========

`ElasticUtils <https://github.com/mozilla/elasticutils>`_ is a Python
library for building and executing Elasticsearch searches.


v0.7 released!
==============

Turns out I haven't announced an ElasticUtils release since August
2012. Why? Partially because up until now, I always had deep-seated
problems with ElasticUtils and wasn't excited about announcing yet
another version with things I disliked in it.

I feel really good about v0.7 for a variety of reasons. Let me tell
you some of them:

1. We switched from pyes to pyelasticsearch. I'm really happy with
   this.

2. There was a monumental effort to fix sharp edges in the API,
   generalize bits that needed generalizing, improve the quality of
   the software, improve the test suite, improve the docs, ...

   Doing a ``git diff --stat`` tells me::

       65 files changed, 6164 insertions(+), 2716 deletions(-)

   That's a lot of change for a small project like this.


If you're using ElasticUtils, I highly encourage you to update to
v0.7. We're using it on `Input <https://input.mozilla.org/>`_ and
`Support <https://support.mozilla.org/>`_ already.

For the complete list of what's new, `What's new in Version 0.7
<https://elasticutils.readthedocs.org/en/v0.7/changelog.html#version-0-7-released-june-12th-2013>`_.

Many thanks to everyone who helped out: Erik Rose, Jannis Leidel, Rob
Hudson, Steve Ivy, Will Kahn-Greene (oh, that's me!), Chris McDonald,
Ricky Rosario, James Socol, Giorgos Logiotatidis, Mike Cooper,
Grégoire Vigneron, Chris Sinchok and Brandon Adams.

If you have any questions, let us know! We hang out on ``#elasticutils``
on irc.mozilla.org.
