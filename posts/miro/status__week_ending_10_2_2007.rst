.. title: status: week ending 10/2/2007
.. slug: status__week_ending_10_2_2007
.. date: 2007-10-03 00:21:33
.. tags: miro, work

I didn't get a whole lot checked in over the last week.

I put `Planet Miro <http://planet.getmiro.com/>`__ together. I've been
toying with a timeline script for
`Bugzilla <http://bugzilla.pculture.org/>`__ which is now partially
working (but on my local machine). I'm trying to figure out how to keep
the script and related templates separate but a part of the Bugzilla
code so that if/when we upgrade Bugzilla, we don't have to spend time
extracting the changes I've been making and re-do them. I haven't come
up with any good answers, though. I'm thinking I may just check a bunch
of files into SVN with a big README on how to apply them to Bugzilla and
which files go where. This is a big paragraph, but I only spent maybe 3
or 4 hours on Bugzilla stuff.

In Mediabar land, I added the code for adding and editing helper program
information. It still needs some code for verifying the data that the
user entered and there are a few other FIXMEs for things that need to be
finished off. But for the most part, users can add, edit, and delete
helper programs and assign them to the various media types and that all
works now.

I've spent a majority of my time working on re-architecting the
extension to be tab-friendly--mostly learning how all the XUL pieces fit
together. I think I need another day or two to finish my research, then
I'll do the re-architecture. I started writing up a specification, but
my ideas and understanding of what's going on is changing too quickly to
make that worth-while at this stage. I'll finish the specification up in
a couple of days.

Neil has been moving along with other bug fixes, so we've been getting
things done even though the project is waiting on the tab-friendly
re-architecture code changes.

In Miro land, I did a pass at updating the miro.1 man file and I think
that's about it. Chris took some of the bugs I was sitting on and fixed
them. I want to spend some time to finish the other ones off since
they're worth fixing.

Also, there was a guy on #miro-hackers last week named, but I forget his
name. He was asking whether we want help with our Windows platform. I
had to leave, though, and I haven't seen him online since.

Overall, it's been a week of spinning my wheels wishing I had a lot more
prior experience with JavaScript and XUL.
