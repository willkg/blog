.. title: Deleting tickets in Trac
.. slug: tracdeletetickets
.. date: 2006-12-07 21:27:56
.. tags: software, dev

I'm having problems with spam in my Trac instance which keeps track
of my PyBlosxom plugins.  It's ...  irritating.  Anyhow, now that classes
are almost over, I decided to poke around and figure out how to delete
them rather than mark them as "invalid".  Turns out it's really easy:

.. code-block:: shell

   $ trac-admin [project-dir] ticket remove [ticket-number]
