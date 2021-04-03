.. title: Added locking to Pyblosxom
.. slug: locking
.. date: 2004-01-21 20:13:27
.. tags: python, dev, pyblosxom

I just added locking to Pyblosxom to allow separate Pyblosxom
requests to synchronize on centralized data.  In my case, the
data is a file of how many views each of my blog entries has
gotten.  It seems to be pretty functional.  It's something I
had coded in my viewcounts plugin, but I've moved the code
(and added to it) into the tools module so we can all use the
same base.

An example of usage is this:

.. code-block:: python

   from Pyblosxom import tools

   LOCKNAME = "viewcounts.dat"

   lockret = tools.get_lock(request, LOCKNAME)
   if lockret:
       # yay -- we have the lcok
       pass
   else:
       # foo -- we don't have the lock
       pass


   if tools.has_lock(request, LOCKNAME)
       # yay -- we have the lock
       pass
   else:
       # foo -- we don't have the lock
       pass

   tools.return_lock(request, LOCKNAME)


The code is in CVS.  It'll go into the next version.  Also, I
added a unittest module to the code base.
