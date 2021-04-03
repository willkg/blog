.. title: PyBlosxom 1.3.1 released
.. slug: pyblosxom.1.3.1
.. date: 2006-02-07 22:55:36
.. tags: pyblosxom, dev, python

Bunch of bug-fixes for things I didn't catch the first time around.

Changes:

* fixed num_entries behavior
* fixed RSS 0.9.1, RSS 2.0, and Atom 1.0 feed templates
* fixed ``$body_escaped`` variable
* fixed problem with static rendering where it'd render ``/index.html``
  and ``//index.html`` if you had entries in your root category
* merged ``ReadMeForPlugins`` documentation into the manual and added/fixed
  some more content

It's a good release.  Many thanks to Norbert (current Debian packager),
Joey, Joerg, and the many people who upgraded to PyBlosxom 1.3 despite
the fact we have no regression or unit testing system [1]_ --they 
are brave people.

.. [1] This is a bad thing--we should fix this.
