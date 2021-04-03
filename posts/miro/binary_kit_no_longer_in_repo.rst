.. title: Binary kits are no longer in the repository
.. slug: binary_kit_no_longer_in_repo
.. date: 2009-11-11 19:20:49
.. tags: miro, work

I finished the work to remove the binary kit data from the ``miro``
repository today. Removing the binary kit data from the repository
changed all the shas. To alleviate the problems this causes, I did the
following:

#. Ran a ``git filter-branch --commit-filter`` that added a line to the
   end of every commit message stating what the original commit sha was.
   The shas are referenced in Bugzilla, so this maintains the
   papertrail.
#. Moved the "old git repository" to ``miro.old``. If you're building
   Miro versions prior to Miro 2.6, it'll probably be easier to do that
   in the old git repository because the binary kit material is there.
#. Binary kit materials were moved to separate repositories.

The end result of this is that we went from 900mb for the repository and
a full checkout to about 136mb. Clones are faster, it uses less space on
disk, and you're not saddled with a bunch of binary date you probably
aren't going to use. It's also much easier on the build boxes which are
old and don't have a lot of disk space kicking around.

If you have any questions, comments, or problems, let me know.
