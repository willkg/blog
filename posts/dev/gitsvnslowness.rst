.. title: When git-svn is painfully slow...
.. slug: gitsvnslowness
.. date: 2009-06-19 23:58:57
.. tags: dev, miro

When I upgraded from Intrepid to Jaunty, I noticed that <code>git svn</code> 
things were **painfully** slow.  I had looked into this before, but 
couldn't remember how I found the answer or what it was.  After skimming
through thousands of lines of IRC logs, I re-rediscovered what I discovered
the first time.

.. code-block:: shell

   rm -rf .git/svn
   git svn rebase --all

I found it at `this site <http://oebfare.com/blog/2008/dec/08/gitify-python-svn/>`_.
