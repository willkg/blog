.. title: Lyntin status: 2/17/2003
.. slug: status7
.. date: 2003-02-17 22:14:28
.. tags: dev, lyntin, python

I've finished all the programming for Lyntin 3.2.  I plan to release
it next weekend.  Between then and now if you want to grab the latest
in CVS and test it out and report bugs, that'd help a great deal!

Things that Lyntin 3.2 will have:

* new scheduler system with the ability to schedule commands
  to kick off at a given time
* redid the #import stuff so it's now #load and #unload
* refactoring of the thread manager, the datagrep buffer, 
  the ticker (now uses the brand new scheduler), and session
  shutdown
* fixed the EOR issue, #textin, #config
* added the #grep command and removed #datagrep and 
  #datagreplines
* implemented the #bell command and added bell functionality
  to the textui

There's some neat stuff in here and some minor optimizations
and fixes to documentation as well.  It'll be a good release.
