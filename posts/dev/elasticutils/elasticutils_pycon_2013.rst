.. title: ElasticUtils sprint at PyCon US 2013
.. slug: elasticutils_pycon_2013
.. date: 2013-03-20
.. tags: mozilla, webdev, work, elasticutils, dev, python


What is it?
===========

`ElasticUtils <https://github.com/mozilla/elasticutils>`_ is a Python
library for building and executing ElasticSearch searches.


PyCon US 2013 sprint
====================

I was only at the sprints for a single day. Rob and I spent some time
working on elasticutils. Several good things came out of that:

1. Rob wrote up an elasticutils Django middleware which throws a 501
   or 503 page if an unhandled pyelasticsearch or requests exception
   is raised

2. I fixed the Django tasks, added a test, and updated the
   documentation

3. I cleaned up the Django ElasticSearchTestCase class

4. I spent a bunch of time thinking about queries, syntax and
   functionality


Someone on IRC asked whe the next version of elasticutils will go
out. I have no schedule right now, but I think it's important to let
the code get used by projects that don't mind being bleeding edge and
bake for a bit. The code in master tip right now is 0.7.dev and the
big change since 0.6 is that we switched from pyes to
pyelasticsearch. That's a big change---the more baking it does, the
better.

Having said that, a release depends mostly on how much free time I
have in the near future. I'm about to lose all free time for a bit, so
my guess is that we won't see a 0.7 release until this summer unless
there's a compelling reason to push one out.

In the meantime, I'm actively maintaining the v0.5 and v0.6
branches. I'd like to stop maintaining the v0.5 branch, but need to
get Mozillians and AMO off of it first.

If you have any questions, let us know! We hang out on ``#elasticutils``
on irc.mozilla.org.
