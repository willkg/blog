.. title: Git in cygwin: fatal: early EOFs
.. slug: gitincygwin
.. date: 2011-01-09 17:19:03
.. tags: dev

I was having a hard time with "fatal: early EOFs" messages when doing a 
<tt>git fetch</tt> in my cygwin session on my Windows dev box.  Found
`good solution at StackOverflow <http://stackoverflow.com/questions/2505644/git-checking-out-problem-fatal-early-eofs>`_:
run the following:

.. code-block:: shell

   % git config --add core.compression -1

That fixed it for me.  Writing a blog entry about it so I have this fix
forever.
