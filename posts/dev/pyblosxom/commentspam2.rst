.. title: Comment spam (part 2)
.. slug: commentspam2
.. date: 2004-08-01 12:55:51
.. tags: blog, python, pyblosxom

I noticed that almost all the comment spam I get has the word "casino"
in it. I added some code to the comment plugin to check the comment for
the word casino and if the word is there, I ditch the comment. That
seems to work very nicely (in the last 24 hours, it's ditched 7 bad
comments and no good ones) though it's a short-term fix.

Long-term, I have a few thoughts. I may re-write portions of the
comments plugin so that it saves comments originally in an "approval"
stage. Then I'll write a command-line program that allows me to approve
or reject all the comments in the "approval" stage one by one. That'll
be pretty easy to deal with though it introduces a time-delay between
when a comment is created and when it is posted.

Alternatively, I could just write a command-line program that goes
through all the comments since the last one I "approved" and allows me
to go through them one by one and weed out the bad ones.

Still, given that my blogs aren't related to casinos in any way, using
"casino" seems to be a good filter.
