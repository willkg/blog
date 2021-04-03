.. title: MozRepl
.. slug: mozrepl
.. date: 2007-09-30 10:10:39
.. tags: dev, software

I've been doing Firefox extension development and it's been going 
pretty slowly because it's hard for me to figure out what's going 
on when things are running (and I'm not wildly familiar with the 
things I'm working with).

After whining about how I wish there was a REPL for JavaScript, I 
did a Google search and came across 
`MozRepl <http://dev.hyperstruct.net/mozlab/wiki/MozRepl>`_.
It's helping a lot so far.  I'm not spending hours hunting for object 
documentation anymore.

On an interesting note, you connect to MozRepl with telnet and it has 
a line-mode interface.  Turns out that Lyntin (a mud client I worked 
on years ago) works fantastically for this.  I would assume most mud 
clients would because at heart they're line-mode telnet clients with 
a bunch of features designed to remove repetition in common tasks and 
make it easier to skim large amounts of output quickly without having 
to read through all of it.

For example, say I was interested in skimming changes for the 
``title`` attribute.  I could do this:

.. code-block::

   #highlight {reverse,green} {title=*}


That will highlight lines with "title" in them from "title" onwards.
