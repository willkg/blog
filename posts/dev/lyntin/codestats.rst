.. title: Lyntin as a large Python project
.. slug: codestats
.. date: 2003-01-23 13:26:12
.. tags: dev, lyntin, python

Josh discovered a page on the Python wiki that talks about
`Large Python Projects <http://www.python.org/cgi-bin/moinmoin/LargePythonProjects>`_.
Turns out that Lyntin is one of three listed.
There are probably a lot of other large Python projects out there
so that doesn't really mean quite what we think it means.  Anyhow, they
list us as having 11,856 lines of code back in July of 2002.

Josh and I then used their 
`pycount.py <http://starship.python.net/crew/gherman/playground/pycount/pycount.py>`_
script to figure out how many lines we have now and 
discovered we have 14,024 total lines 
(`listing here </~willkg/dev/lyntincodestats.txt>`_) of which 
6,157 lines are actual code, 4,649 are doc-strings and 1,171 are comments.
That means that 41.5% of our code-base is documentation.  That's pretty 
cool.  How many projects can say that about themselves?
