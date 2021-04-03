.. title: overhauled logging
.. slug: logfile
.. date: 2002-11-14 21:42:13
.. tags: dev, lyntin, python

We had this idea to overhaul the logging functionality so that
it's in a manager just like most of the other functionality.  I
just finished this up tonight.  I'm tossing around other arguments
you would want to pass on the command line--haven't gotten there
yet.

The next big issues:

* move the ticker to its manager
* figure out if command parsing needs some attention in terms of 
  unescaping characters
* write help files for lyntin and tintin eval modes
* uncouple hooks from hooks.py so module writers can write their
  own hooks
* build a setup.py for distutils installation
