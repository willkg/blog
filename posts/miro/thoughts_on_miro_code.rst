.. title: Thoughts after commenting on someone's frustrations in Fedora bug 494505
.. slug: thoughts_on_miro_code
.. date: 2009-06-30 16:01:24
.. tags: miro, dev, work

I'm subscribed to all downstream Miro bugs in the Fedora bug-tracker.
I'm also subscribed to all downstream Miro bugs in the Debian bug
tracking system. It helps a lot to triangulate issues with external
component versions and the myriad of other problems that come with
developing an application that runs on Linux distributions.

Today, Rudd-O, who I've never met, ranted on the state of the Miro
codebase in bug 494505 in the Fedora bug-tracker. I responded with this
https://bugzilla.redhat.com/show_bug.cgi?id=494505#c13.

I thought I should blog about that since I really don't blog enough
about the whos and the whys and the hows of Miro development.

After Miro 1.2, we decided to embark on some serious rewrites to fix big
problems with the way Miro was structured. Thus each major version since
Miro 1.2 has involved signficant overhaul.

Miro 2.0 saw a re-write of the ui. In doing so, we rewrote the Windows
platform code which used to be a XULRunner application but is now a
Python application using GTK. The ui rewrite fixed a lot of internal
codebase problems, but the primary use case was to fix performance
problems when displaying feeds with lots of items in them. Display isn't
perfect, but it scales a lot better now. As a side note, it's not that
we didn't like XULRunner, it's that we wanted to merge the windows and
gtk-x11 platforms to make it easier to develop going forward.

Miro 2.5 (not quite out yet, but hopefully soon!) involved a re-write of
the data storage code. It is a good thing to do in general, but the
primary use case here was to fix performance problems with startup. No
longer does Miro need to load the whole database to load the ui; now it
can do it in parts. This speeds up Miro startup for a lot of people
especially those with large databases. As an added bonus, the database
is a regular relational database which other programs can access to see
Miro managed media and metadata.

We don't have plans for the next version yet, but there's still a lot of
stuff to re-write and make better. The downloading code needs
refactoring. The feedparsing code needs good regression tests and once
we have good regression tests, it should get refactored. There's a lot
of code that needs to be documented and cleaned up. We need to add
support for new standards and specifications. We need to add support for
really important features like subtitles. We want to build a plugin
framework allowing people to extend Miro in their own ways to meet their
needs.

That's what we're working on, but there's no way we can do it all at
once. We could use your help. If you can't contribute code, contribute
funding for someone else to dedicate the time to work on code.

We are all Miro users. We are all Miro evangelists. We are all Miro
testers. We are all Miro developers. Miro was made by you and me for you
and me. Long live Free Software and Open Video!
