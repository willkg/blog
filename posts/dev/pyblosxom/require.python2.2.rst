.. title: changing the requirement to Python 2.2?
.. slug: require.python2.2
.. date: 2005-02-21 17:46:09
.. tags: pyblosxom, dev, python

Steven's been doing development on PyBlosxom to allow for other frameworks
than plain CGI.  The architecture changes he's making solves some other
issues as well.  The problem we've bumped into is that one of the things
he wants to do requires us to change the minimum Python version from 2.1
to 2.2.

Details `here <http://thread.gmane.org/gmane.comp.web.pyblosxom.devel/1401>`_.

Bill noted that it's likely that PyBlosxom won't work in 2.1 as it is now 
anyhow.  I'm not sure--I don't have Python 2.1 anymore.

So the question is would it be ok to change the minimum requirements.  
Some folks who cannot change the version of Python they have will have 
issues with this (obviously), but is it a good idea anyhow?  Is the
world at a place where it's common to require at least Python 2.2 a for
projects?
