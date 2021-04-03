.. title: pystaticfile v.1.5 released
.. slug: pystaticfile.1.5
.. date: 2004-04-05 15:13:35
.. tags: pyblosxom, plugins, dev, python

I added the Request object to the locals for eval_python_block.  I
also did away with the "printout" kluge I had--you can use print
now.

If you used an old version and are upgrading to this version, you'll
need to convert all your "printout" function calls to regular print
statements.

Find it in `my plugin index </~willkg/dev/pyblosxom/>`_.
