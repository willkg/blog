.. title: File locking in Python--help!
.. slug: filelocking
.. date: 2004-07-01 11:10:50
.. tags: dev, python, bluesock

I wrote my own web-mail client 
(`bluemail <http://bluesock.org/~bluemail/>`_) because I wanted
a web-mail client that would work along-side PINE and figured I'd just
roll my own in Python.  I work on it from time to time--mostly when
someone requests new features.  Right now I'm trying to implement
deleting of items in a given folder.

The problem I'm having is a file locking issue.  When the user clicks
on the ``INBOX`` link, it opens up their inbox file (an mbox file in 
``/var/spool/mail/``) as the user.  That works great.  I parse out the mbox
and display a bunch of email one-liners.  The problem comes in that I can't
seem to open the file as ``r+``, lock it, parse it into email, change some
of the email (whether by deleting the email from the mbox file or changing
the attributes of the email [i.e. marking the email as having been answered]),
then write the changed file back to disk without the possibility of
having another process (our MTA, for example) slipping in and changing
the file beneath me.

Right now, I open the file like this:

.. code-block:: python

   import fcntl

   f = open("/some/file", "r+")
   fcntl.flock(f, fcntl.LOCK_EX)


That should work fine (as far as my research has told me).  I did notice
some places that say that ``LOCK_EX`` only works when you open the file
in "a" or "w" mode, but I've got it opened as "r+" which means I'm going
to update it later, so I'm puzzled.

Anyhow, using the code above doesn't seem to lock the file.  I can 
run the above code thereby "locking" the file and then in another
process open the file, read the file, and write to it.  That indicates
to me that it's not really locked.

Any ideas how I can resolve this?  I need to be able to open a file for
reading and updating and lock it so that other processes can't change
the file between my read and update cycles.  I'm running the code on
a Debian GNU/Linux box with Python 2.3.
