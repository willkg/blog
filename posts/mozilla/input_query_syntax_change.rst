.. title: Input: changed query syntax across the site
.. slug: input_query_syntax_change
.. date: 2014-05-13 12:00
.. tags: mozilla, work, input

Better search syntax is here!
=============================

Yesterday I landed the changes for `bug 986589
<https://bugzilla.mozilla.org/show_bug.cgi?id=986589>`_ which affects
all the search boxes and search feeds on `Input
<https://input.mozilla.org>`_. Now they use the `Elasticsearch
<http://elasticsearch.org/>`_ `simple-query-search
<http://www.elasticsearch.org/guide/en/elasticsearch/reference/0.90/query-dsl-simple-query-string-query.html>`_
query instead of the hand-rolled query parser I wrote.

This was only made possible in the last month after we were updated
from Elasticsearch 0.20.6 (or whatever it was) to 0.90.10.


Tell me more about this ... syntax.
===================================

I'm pretty psyched! It's pretty much the minimum required syntax for
useful searching. It's kind of silly it took a year to get to this
point, but so it goes.

To quote the Elasticsearch 0.90 documentation::

    +  signifies AND operation
    |  signifies OR operation
    -  negates a single token
    "  wraps a number of tokens to signify a phrase for searching
    *  at the end of a term signifies a prefix query
    ( and )  signify precedence


Negation and prefix were the two operators my hand-rolled query parser
didn't have.


What does this mean for you?
============================

It means that you need to use the new syntax for searches on the
dashboard and other parts of the site.

Further, this affects feeds, so if you're using the Atom feed, you'll
probably need to update the search query there, too.

Also, we added a ``?`` next to search boxes which links to a wiki page
that documents the syntax with examples. It's a wiki page, so if the
documentation is subpar or it's missing examples, feel free to let me
know or fix it yourself.
