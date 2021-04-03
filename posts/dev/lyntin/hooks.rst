.. title: overhauled hooks in lyntin
.. slug: hooks
.. date: 2002-11-20 22:25:55
.. tags: dev, lyntin, python

After talking to Josh for a bit, we decided that we should overhaul
hooks a bit before putting out 3.0.  The reasons for this are mostly
that the existing hook system didn't allow module developers to build
hooks easily and have those hooks referenceable by other modules
written by other developers. 

I just finished coding up the HookManager class which holds registered
hooks.  Hooks can now be retrieved via the old method (accessing the 
Hook directly) or alternatively through the exported module which
talks to the HookManager which knows about all registered hooks.  I
spent some time overhauling the existing Lyntin code to account for
this adjustment and it's working nicely so far.

Hopefully this is the last big issue to solve before 3.0.  It needs
to sit and cook for a bit, though, so this will push the 3.0 release
off at least a week--possibly more.
