.. title: JDEE and Ant
.. slug: jdee_ant
.. date: 2004-12-07 12:21:53
.. tags: java, dev

I've got JDEE 2.3.4 and Apache Ant 1.5.  The problem I was having was
that I'd get this error message whenever I tried to do C-c C-v C-b
(i.e. build my project using ant):

.. code-block:: 

   ant -buildfile 'c:/Tools/src/spiderutil/build.xml' -emacs
   Buildfile: 'c:\Tools\src\spiderutil\build.xml' does not exist!
   Build failed

   Compilation finished at Tue Dec 07 11:22:24


Anyhow, after some poking around, I discovered 
`this post <http://article.gmane.org/gmane.emacs.jdee/3910/match=+buildfile+exist>`_
(http://article.gmane.org/gmane.emacs.jdee/3910/match=+buildfile+exist) 
which helped me fix my issue.  I went into jde-ant.el and removed two
instances of "delimiter" and now everything works super duper.
