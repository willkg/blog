.. title: gtkx11 platform and xulrunner 1.9 status
.. slug: gtkx11_platform_and_xulrunner_1_9_status
.. date: 2008-03-26 18:36:41
.. tags: miro, work

I merged the changes into the Miro-1.2 branch and cut a tarball. You can
get the tarball at http://pculture.org/nightlies/Miro-1.2.2-test.tar.gz.

This code needs testing from distributions that are only using xulrunner
1.9. It "works for me" with Ubuntu Hardy Beta 1 today (but didn't work
yesterday) and it works with Ubuntu Gutsy (where it compiles against
Firefox). I haven't tested it on other distributions.

For the most part, I fixed things that were obvious compile/runtime
issues. I didn't delve into the API differences between xulrunner 1.8
and 1.9 and fix deprecation problems and things of that nature. The
changes I made are mediocre, but they seem to work for me. They're
loosely based on changes in the Ubuntu packages. I talked about that in
a previous blog entry.

I need help testing this with other distributions. I also need help
making sure that no other changes are required. Reply in the comments
below, toss a comment in `bug
9692 <http://bugzilla.pculture.org/show_bug.cgi?id=9692>`__, ping me on
IRC, and/or send me an email to my pculture.org email address.

The more help and the more eyes we get, the more likely that the code
will work where you need it to work.

If no one helps out, then I'll probably just release it and see what
happens.

**Note:** The changes in the above linked tarball are NOT in the Miro
1.2 or 1.2.1 releases. This is not a final release. This is for testing
purposes only.
