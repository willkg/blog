.. title: Paste and WSGI
.. slug: pasteandwsgi
.. date: 2007-09-11 23:11:46
.. tags: pyblosxom, dev, python

I'm hanging out on ``#pyblosxom`` on ``irc.freenode.net`` more often now that
I'm hanging out on ``irc.freenode.net`` for work during the day.  Zeth was on
today and pointed out that if you're running `PyBlosxom
<http://pyblosxom.sf.net/>`_ with `Paste <http://pythonpaste.org/>`_, then the
default configuration doesn't allow for css and image files to be served.

This weekend, I wrote a media serving plugin for PyBlosxom which solves this
issue, but I decided to spend some time to write a WSGI application to do the
same thing and use Paste's ``urlmap`` to handle the routing.  It took
10 minutes to throw together and it works nicely.  I'll clean it up and throw
it in the Trac instance tomorrow.  Over time, I'm liking WSGI more and more.
