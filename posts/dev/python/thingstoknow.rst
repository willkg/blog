.. title: Useful things to know--stdin, stdout, and stderr
.. slug: thingstoknow
.. date: 2009-07-30 18:54:08
.. tags: python, dev

I was reviewing something and learned that Python saves the original
``sys.stdin``,
``sys.stdout``,
and ``sys.stderr``
as
``sys.__stdin__``,
``sys.__stdout__``,
and ``sys.__stderr__`` respectively.  That's pretty handy to
know.  Works in at least Python 2.5 and up--I didn't test earlier 
versions.
