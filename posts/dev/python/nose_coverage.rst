.. title: Nose and coverage
.. slug: nose_coverage
.. date: 2007-12-06 13:29:20
.. tags: dev, python

I'm working on improving the PyBlosxom testing situation and in the process
of doing that ran into a problem with 
`nose <http://nose.python-hosting.com/>`_ (version 0.10.0) and 
`coverage <http://nedbatchelder.com/code/modules/coverage.html>`_ (version 2.77).
Both installed with ``easy_install``.

When running:

.. code-block:: shell

   $ nosetests --verbose --with-coverage --cover-package=Pyblosxom --include unit
   $ nosetests --verbose --with-coverage --cover-package=Pyblosxom --include functional


I bumped into the problem described `here (nose.python-hosting.com) <http://nose.python-hosting.com/ticket/119>`_
and 
`here (code.google.com) <http://code.google.com/p/python-nose/issues/detail?id=85>`_.
The solution is to either:

* remove ``coverage.py`` from ``/usr/bin``, or
* change the filename from ``/usr/bin/coverage.py`` to ``/usr/bin/coverage``
