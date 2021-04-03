.. title: booklist 1.6
.. slug: booklist.1.6
.. date: 2004-09-15 10:27:02
.. tags: pyblosxom, dev, python, plugins

Brett discovered some issues with booklist as it interacts with
comments.  So this fixes those issues.

You should note that if you're using booklist and comments, you should 
have at least 2 books in your list.  Otherwise comments sees it as
a single entry, decides to show comments for it, and then stomps on
the property in the entry that dictates which template to use.  That's
a bug in comments that needs to get fixed.

`Get it on my pyblosxom plugins listing </~willkg/dev/pyblosxom/>`_.
