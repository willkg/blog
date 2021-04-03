.. title: PyBlosxom status: 07/25/2005
.. slug: status.07252005
.. date: 2005-07-25 18:31:14
.. tags: python, dev, pyblosxom

I implemented `Matt Weber's
idea <http://www.mattweber.org/Programming/PyBlosxom/PyBlosxom_Plugins_Update.html?showcomments=yes>`__
to show comments when bl_type = "file" instead of depending on a
"showcomments=yes" in the querystring. I didn't remove the checking for
"showcomments=yes", however--I figure having both covers all our bases.
This fixes the ramifications of a poor decision on my part.

I made some changes to the debug renderer to make it easier to use. It
now sorts the keys for mappings and prints the keys in blue. It's much
easier to read now.

I submitted a bug report on the PyBlosxom package based on an email I
got from Ted from Dave from Zack. I posted a `security
issue <http://pyblosxom.sourceforge.net/blog/security/security.07252005.html>`__
on the PyBlosxom web-site to notify users. I also forwarded the issue to
the pyblosxom-users mailing list. Hopefully the news will filter down to
all the people that need it.

I'm going to do some more PyBlosxom work over the next week. I want to
merge some functionality in from plugins into the core. I first need to
merge all the changes I've done on 1.2 back into main branch. Then I'll
do the work in main and create a 1.3 branch when I release 1.3. If there
are any features people are itching for, now's the time to let me know.
Anything I don't plan on working on, I'll toss on a web-page on the
web-site so everyone can see the wishlist and the status of where things
are. It's interesting to note that the wishlist and a todo list are
themselves in the wishlist and todo lists.
