.. title: Another quick PyBlosxom plugin
.. slug: viewcount
.. date: 2003-03-15 21:21:59
.. tags: python, dev, pyblosxom

This one counts the number of views for a given entry.  It only
counts the entry if the renderer asks for the ``$viewcount``
value.  At that point, the viewcount module will figure out how
many views this entry has had (using the id on the entry), add
one to it, save the new value, and then return the new value
to be displayed.

**Updates:**

3/19/2003 Moved code to `here </~willkg/dev/pyblosxom/>`_.

4/8/2003 Updated code to new architecture.
