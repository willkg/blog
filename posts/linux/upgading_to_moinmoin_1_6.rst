.. title: Upgrading to MoinMoin 1.6
.. slug: upgading_to_moinmoin_1_6
.. date: 2008-04-26 00:00:48
.. tags: ops, software

A couple of days ago, I did a dist-upgrade on my server which runs Debian. 
I'm not sure what version I had prior to the upgrade, but after the upgrade 
I'm at 1.6.2.  The problem is that the wiki syntax is different, so my wiki
data was mildly hosed.  I ended up spending 45 minutes to an hour trying
to figure out how to migrate the data.

The magic script is ``/usr/share/python-support/python-moinmoin/MoinMoin/script/moin.py``.
You need to run it like this:

.. code-block:: shell

   $ ./moin.py --config-dir=/path/to/wikiconfig.py/dir/ migration data


The other problem I had is that I had no ``meta`` file in my data directory and
so the ``moin.py`` script would die with a stack trace like this::

    Traceback (most recent call last):
      File "./moin.py", line 24, in ?
        run()
      File "./moin.py", line 15, in run
        MoinScript().run(showtime=0)
      File "./../../MoinMoin/script/__init__.py", line 138, in run
        self.mainloop()
      File "./../../MoinMoin/script/__init__.py", line 251, in mainloop
        plugin_class(args[2:], self.options).run() # all starts again there
      File "./../../MoinMoin/script/__init__.py", line 138, in run
        self.mainloop()
      File "./../../MoinMoin/script/migration/data.py", line 44, in mainloop
        curr_rev = meta['data_format_revision']
      File "./../../MoinMoin/wikiutil.py", line 472, in __getitem__
        return dict.__getitem__(self, key)
    KeyError: 'data_format_revision'


I assumed that I had some version of 1.5 previously and so I created a 
``meta`` file with this in it::

   data_format_revision: 01050800


After doing that, the ``moin.py`` script worked nicely and all my wiki data is
in the correct syntax now.

**Update:**

4/26/2008 - Fixed some words to make the ``meta`` file creation step clearer.
