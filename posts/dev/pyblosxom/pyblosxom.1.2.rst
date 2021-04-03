.. title: PyBlosxom 1.2 plans
.. slug: pyblosxom.1.2
.. date: 2005-03-08 21:53:04
.. tags: pyblosxom, dev, python

We're going to try to push out PyBlosxom 1.2 in the next week or two.
Steven did a lot of work fixing up static rendering and also fixing
the architecture pieces that caused PyBlosxom to kind of suck when
used in various frameworks like WSGI, Twisted and mod_python.  I'm
also going to do another round of documentation content.

We're going to push fixing the file handling to the next version.
We want to allow for index caching and also reduce the number of times
PyBlosxom walks your blogdir for entries.  Both of these new abilities
will significantly reduce the time it takes for large blogs to
render.  Getting there....

The plan is to have these changes in before Ted's talk at PyCon.
