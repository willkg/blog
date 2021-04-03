.. title: statusbar module
.. slug: wbgstatusbar
.. date: 2002-11-23 11:30:39
.. tags: dev, lyntin, python

I bumped into a full explanation of escape codes in xterms and 
it occurred to me that I could set the title bar of the xterm
session and thus have a non-moving status bar of sorts in the
textui.  I spent 5 minutes slapping together a module that sets
the title bar for the textui (if you're using an xterm) and
the tkui with name/value pairs that you set using the #setstatus
command.

Link to said module is `here </~willkg/dev/wbgstatusbar.py>`_.

Incidentally, the ability to whip together additional functionality
like this in such a short period of time is what makes Lyntin such a
powerful mud client.
