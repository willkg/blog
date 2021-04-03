.. title: review flag; contributing patches
.. slug: review_flag__contributing_patches
.. date: 2008-06-18 10:25:51
.. tags: miro, work

We've had a few people contributing patches for the Miro codebase. I
decided it was time to add a review flag like Mozilla has in their
Bugzilla instance. This makes it easier for us to keep track of
attachments that are waiting on reviews.

As such, I added a "review" flag to our Bugzilla instance for
attachments.

I thought I'd talk a little bit about contributing patches.

Guess what? You're a happy Miro user except for one little thing that
really annoys you. You head on up to `the Miro Bugzilla
bug-tracker <http://bugzilla.pculture.org/>`__ to see if this is a
bug/feature that someone else has reported already. Wow--turns out it
has been reported. Not only that, but there's been some analysis done
and some speculation as to a good attack vector for fixing the problem.

So you roll up your sleeves, add a comment on the bug stating you're
going to work on it, set yourself as "assigned", dust off your favorite
editor, skim through the `Miro development
wiki <https://develop.participatoryculture.org/trac/democracy/wiki>`__
for the svn repository information and build instructions, and get to
work.

A few hours later you've got it working on your machine. You run:

::

   svn diff > bugid.patch

to generate a ``.patch`` file containing the changes you've made.

You visit the bug in the Miro Bugzilla bug-tracker, find the bug you
were working on, and click on "add attachment". You'll see the following
screen:

.. thumbnail:: /images/reviewflag.png

   The "Add attachment" page.

Deftly, you upload the patch, click on the "patch" checkbox, select "?"
from the Review flag dropdown and type in ``will.guaraldi@pculture.org``
in the Requestee box.

Then you press the "submit" button!

Will (that's me) gets an email stating that there's an attachment
waiting for review. I add it to my queue of things to look into. If it's
not something I know anything about, I'll find someone else who can look
at it. Then someone will add a comment to the bug reviewing the patch
and ... the rest is iterations on that.

If you're interested in helping out, we've been tagging bugs that we
think are good for people new to the codebase as "bitesized". You can
see a list of them
`here <http://bugzilla.pculture.org/buglist.cgi?quicksearch=bitesized>`__.
