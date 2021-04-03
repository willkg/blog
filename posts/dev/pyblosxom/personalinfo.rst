.. title: Plugin that injects entries into the list
.. slug: personalinfo
.. date: 2003-03-18 21:20:58
.. tags: python, dev, pyblosxom

This plugin registers with the prepareChain and injects an entry
to the beginning of the ``entry_list`` that holds personal information
from ``$datadir/personalinfo.dat`` which is a pickled dict.  I have
mine updated via cron at the moment.

I don't really have a wild need to have this information, but it
occurred to me that our system allows for this without any problems.
I mentioned this to the pyblosxom-devel list and Ted replied that we 
need more examples.  I thought about it during lunch and then whipped
together this example (it took 10 minutes again--I'm into these 10 
minute plugins at the moment).

**Updates:**

3/19/2003 Moved code to /~willkg/dev/pyblosxom/ .

1/27/2004 Removed because it's a sucky plugin and there are better ones.
