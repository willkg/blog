.. title: status: week ending 12/4/2007
.. slug: status__week_ending_12_4_2007
.. date: 2007-12-04 20:32:18
.. tags: miro, work

I've been super busy this past week.

I spent the brunt of my time on the Firefox patch. I've solved most of
`bug 303645 <https://bugzilla.mozilla.org/show_bug.cgi?id=303645>`__,
though the output isn't pretty and it doesn't support Yahoo's MRSS or
iTunes enclosures. I think I'll have it figured out in the next couple
of days and submitted to the Mozilla folks. Once I've populated the
enclosures and they're available in the FeedWriter, I can work on what
we really want to do. I still need to figure out how to associate
applications with different feed types. Mozilla froze the trunk today
for the upcoming beta 2, so none of the changes I've done will be
available until beta 3 at the earliest.

I spent several hours looking for enhancements or bugs that lend
themselves to being small 1-5 day tasks for high school/college level
people in the `PSF section of the
GHOP <http://code.google.com/p/google-highly-open-participation-psf/>`__.
I didn't find any that I thought were promising. This is a bit
unfortunate as it'd give us some good exposure, gets us some help, and
would be good for the project. Still, there's a certain amount of work
that would need to be done to be part of the GHOP. The contest lasts
until February, so I'm hoping I can figure something out before the end.

On Friday, Dean and I talked with Henri of
`CivicActions <http://www.civicactions.com/>`__. They work with clients
who produce content and we talked about various directions our groups
can take to help each other. He's particularly interested in how Miro
could interact with mobile and embedded devices. I'm pretty interested
in that, too. I plan on working on that when I get a Nokia n810. I've
written about that in previous posts.

Also, I've been working with Nathan of `Creative
Commons <http://creativecommons.org/>`__ to get Miro to understand and
work with licensing metadata (`bug
9077 <http://bugzilla.pculture.org/show_bug.cgi?id=9077>`__). He's done
most of the work so far; I've been providing feedback and working out
the implementation issues. This is really useful since it allows content
producers to embed licensing data in the feeds that Miro will display to
users viewing the content.

And I've spent some time doing bug triage and talking with users about
various issues, mostly related to packaging.

Current deadlines:

The CreativeCommons birthday is 12/15, so we need to have the 9077 work
done by then.

The Mozilla folks told us that we need to get the patch done before the
end of the month.

We were thinking of doing a Miro 1.1 release mid-month. I want to fix
the packaging scripts so that we can name tags and branches Miro-x.y
instead of Democracy-Player-x.y. I'll probably look into that later this
week.
