.. title: PyBlosxom 1.2 released
.. slug: pyblosxom.1.2.here
.. date: 2005-03-26 23:18:04
.. tags: pyblosxom, dev, python

Seems like it's ok so far.  So I released it rather than continuing to
sit on it.  I've done a lot of work on the manual to cover the areas
that were covered poorly or not covered at all.  There's still a lot
of material to cover, but we're definitely making measurable progress
in that direction.

Steven Armstrong did a lot of work to get mod_python, WSGI, and Twisted
supported.  I'm not sure why anyone would use WSGI or Twisted, though,
since they don't appear to make much difference in how fast PyBlosxom
works.  mod_python definitely helps, though.  Steven has some runtime
statistics at `<http://thread.gmane.org/gmane.comp.web.pyblosxom.devel/1397>`_.

This feels like a good release.  We met some goals, we didn't sit on it
forever, the documentation is an order of magnitude better than it was
for the previous version (though it has a long way to go, still), and we
fixed a bunch of bugs.

Having said that, it's definitely not necessary for people to upgrade.  
I think if your blog works and you don't need to futz with it to get 
additional functionality, leave well enough alone.
