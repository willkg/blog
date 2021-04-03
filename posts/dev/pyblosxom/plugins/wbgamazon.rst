.. title: wbgamazon plugin fixed
.. slug: wbgamazon
.. date: 2004-07-13 10:40:22
.. tags: python, pyblosxom, dev, plugins

Turns out it was creating garbled yucky stuff that hosed my RSS 0.91
feed.  I fixed it so that if it thinks it's outputting to an RSS feed,
it just returns rather than doing the transformation.

I should look into making this a postformatter--that would be better.

`my pyblosxom plugins </~willkg/dev/pyblosxom/>`_
