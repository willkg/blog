.. title: Fewer plugins
.. slug: fewerplugins
.. date: 2004-04-28 16:29:13
.. tags: dev, pyblosxom, blog

I've decided I don't really need to be running all the plugins I had
running.  So I've removed a bunch.  The good news is that removing
a plugin requires the following extremely difficult steps:

* remove the plugin from ``load_plugins`` in my ``config.py`` file

If I want to completely eradicate the plugin:

* delete the plugin file from the file system
* delete all entries in ``config.py`` that have to do with the plugin
* delete any data files the plugin used from the file system

Anyhow, I'm probably going to install comments, pingbacks, trackbacks,
quarter-backs, double-decaf-half-backs, atom, madam, and all the other
possible ways for blogs to intertwine with one-another over the next
week so that I will finally have an inkling of what all the hubbub
is about. [1]_

.. [1] I also want to fix the comments documentation, test all the code, 
   and get everything ready for a 1.0 release some time in my lifetime.
