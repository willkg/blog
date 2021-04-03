.. title: backups with arnie
.. slug: backups
.. date: 2005-08-19 11:41:33
.. tags: home, computers

I finally got around to re-doing the backup system on bluesock.org.  I'm using
`arnie <http://furius.ca/arnie/>`_ this time around.  Previously, I was just
rolling tarballs of things.  arnie allows for incremental backups and it
handles some more of the minor inconveniences that I had with my did-it-myself
system.

Anyhow, so I decide that my backup script with arnie is working nicely and that
I should remove all the test backups I've done so far.  Inadvertently, I remove
one of the directories that I'm backing up.  DOH!

So I got to experience first-hand how difficult it would be to restore from
backup.  It went pretty smoothly and did what I expected it to do.
