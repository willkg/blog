.. title: Dealing with comment spam
.. slug: commentspam
.. date: 2009-12-21 11:33:48
.. tags: pyblosxom, blog

Someone spammed my blog with 400+ comments for some shoes site. Took me
less than 2 minutes to skim the emails, see the pattern, and then remove
all the spam from my comments moderator queue. This sort of thing is the
big strength of PyBlosxom.

I have my blog set up to store comments as individual text files in a
``comments/`` directory. All comments have to be approved before they
make it to the site. Approved comments end in ``.cmt`` and comments in
the moderator queue end in ``.cmt-``. Additionally, comments that
contain one of a series of blacklisted words are rejected automatically.
Any time someone posts a comment, I get an email.

It took me a minute to skim my 400+ emails and notice they're all kind
of the same, 10 seconds to update the blacklist so that I won't get any
additional comments like this in the future, and 10 seconds to remove
all the spam from the queue with:

.. code-block:: bash

    for mem in `grep -rl spamwordhere *`; do rm $mem; done

That was it--spam gone in less than 2 minutes. Took longer to write the
blog post about it.
