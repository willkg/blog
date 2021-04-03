.. title: pyinclude plugin (showing off variables-with-arguments)
.. slug: pyinclude
.. date: 2003-04-08 23:06:05
.. tags: dev, pyblosxom, python

I checked in some changes I made last night which affect how variables
get expanded and what kinds of things we can do with metadata variables.
Now, we can expand the following variable things:

``$foo``
   This is a regular variable with nothing fancy that we could handle before.

``$foo::bar``
   This is variable *bar* in the scoping *foo*.  Variables can now be grouped
   in categories.  Categories can be functionally oriented (utils, calendar,
   date, file, communication, ...) or plugin oriented (pycalendar, pyarchives,
   ...) or whatever.

``$foo::bar("arg1", "arg2", "arg3")``
   This is variable *bar* in the scoping *foo*...  but it's actually a function
   call passing in three arguments all of type string.  The arguments are
   evaluated as Python code, can be of any type, and any quantity.  We only
   pass in the arguments if the value of the variable (in this case
   ``$foo::bar``) is a function.  This allows plugins to take in configuration
   information from other places other than ``config.py``.  For instance, this
   is really useful for a fileinclude kind of plugin where you might want to
   include different files at different points in your templates....  More
   about that later.

So now the following examples are all valid variables:

* ``$foo``
* ``$foo::bar``
* ``$foo::bar(1, 2, 3)``
* ``$foo::bar::bar2({"arg1": 1, "arg2": 2})``
* ``$foo("arg1", 1, {"foo": "bar"})``

In typical fashion (and at Wari's behest), I wrote a quick plugin
which uses this.  It allows you to include files in your head and
foot templates.  I use this to include my .project file so people can
see it on my web-site as well as finger me on my server and I only
have to update it in one place.

Code is `here </~willkg/dev/pyblosxom/>`_.
