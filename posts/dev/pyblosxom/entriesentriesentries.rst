.. title: Entries entries entries
.. slug: entriesentriesentries
.. date: 2003-03-11 21:20:30
.. tags: python, dev, pyblosxom

I just finished the last bit of the overhaul that Blake started which
involved separating retrieval of content from content rendering.  It's
super cool because now content can come from anywhere--it's no longer
tied to a single datasource (sql, file system, ...).

I also just promised to name my first born child the be-yoo-tiful name
of "xmlrpc_username".  I think the way it rolls off the tongue ...  it
...  it just brings a tear to my eye--it's so beautiful.

I also wrote a plugin that looks at the url to see if it's "/plugin_info"
and if it is, then it will build a series of entries based on the
installed plugins:

...

You can see it's output `here </~willkg/blog/plugin_info>`_.  How do you like
them apples?

**Updates:**

3/11/2003 Fixed the code

3/19/2003 Moved code to `</~willkg/dev/pyblosxom/>`_
