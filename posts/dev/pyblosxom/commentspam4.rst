.. title: More comment spam
.. slug: commentspam4
.. date: 2004-11-06 16:30:51
.. tags: pyblosxom, dev, python

I think I've removed over 100 spam comments from my blog in the last 48
hours.  I'm a little tired of it, so I added a few obvious words to my
word blacklist and then I went and modified the comments plugin to allow
for "draft" status.

Then I wrote a small script that goes through the directory, finds all the
comments in draft status, prints each comment to the screen and asks
me what I want to do with it.  That'll prevent comments from getting
published without my manual approval.

It's funny to note that many/most of the comment spam are comments
on my entries on comment spam.
