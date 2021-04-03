.. title: Indentation for if in python when using emacs and python-mode
.. slug: indentation
.. date: 2009-09-10 17:47:40
.. tags: python, dev

I use a four space indent which causes problems when indenting ``if``
statements that span multiple lines.  For example:

.. code-block:: python

   if (a
       and b
       and c):
       if_block_here

The problem is caused because ``if`` is two characters and therefore ``if (``
is four characters--which matches the four space indent.  I end up with code
where I can't easily distinguish if statement from the if block.

After talking about it with Paul and Chris and working out what the specifics
of the problem are, I decided to use double parens.  The above with
double-parens looks like this:

.. code-block:: python

   if ((a
        and b
        and c)):
       if_block_here


That satisfies PEP-8, doesn't change the semantics, and fixes my problem.
It is a little goofy to use double parens, but it's a good enough fix 
until I get around to fiddling with the code that does automatic 
indentation in python-mode.

I'd be interested in other ideas that don't involve using ``\``
at the end of lines if they're out there.
