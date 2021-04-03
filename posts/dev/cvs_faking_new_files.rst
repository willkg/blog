.. title: Pretending to add new files with cvs
.. slug: cvs_faking_new_files
.. date: 2007-12-13 00:26:48
.. tags: dev, software

I was throwing together a patch for Firefox 3 and needed to add some files
to CVS but I don't have add privs.  If I don't add the files, then
they don't show up in the diff.  After a Google search, I bumped
into `fakeadd <http://wimleers.com/blog/cvs-diff-new-files-fakeadd>`_
which tweaks the Entries file so that the new files show up in the
diff.  No clue if that's a good thing, but it certainly fixes the problem
I was having.
