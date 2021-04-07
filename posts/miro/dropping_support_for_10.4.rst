.. title: Dropping support for OSX 10.4 in Miro 3.1
.. slug: dropping_support_for_10.4
.. date: 2010-05-04 15:52:29
.. tags: miro, work

Over the last year, supporting OSX 10.4 has been a pain in the ass for a
bunch of reasons and is costing us a lot of development and testing
time. Adding new features to Miro is cumbersome since we have to work
around OSX 10.4's constraints and implement and test everything on three
different versions of OSX.

For Miro 3.1, we're working on switching Miro from using a home-grown
httpclient to using libcurl (`bug
13010 <http://bugzilla.pculture.org/show_bug.cgi?id=13010>`__). We're
also adding support for converting media files from one format to
another (`bug
13252 <http://bugzilla.pculture.org/show_bug.cgi?id=13252>`__). Both of
these changes add external components that needs that needs binary kit
support for OSX. After some discussion, we've decided to draw the line
here.

Miro 3.1 and future versions will no longer be supported on OSX 10.4.

It's hard to tell exactly how many users are still using 10.4 since we
don't sell Miro and we use OSUOSL for distributing binaries. We can get
some probably-in-the-same-ballpark numbers from analytics on Miro Guide.
I wrote some numbers in the :doc:`minutes for the 04/07/2010
devcall <devcall_20100407>`.
These numbers suggest that of the 470,000 users who looked at the Miro
Guide, 12% of them are using OSX 10.4. Note that this is not 12% of all
Miro users--just 12% of Miro users on OSX.

That's a large number of users and we're cognizant that dropping support
for OSX 10.4 orphans these users. However, Miro 3.0 is a solid release,
so it's not the case that we're orphaning them on a bad release.

It'd be great if someone who has OSX 10.4.11 installed wanted to take up
the torch and continue support for Miro on that system. If you're
interested, let me know and I'll hook you up with our OSX dev.

Comments, feedback, offers to help support OSX 10.4 going forward,
offers to donate, ... leave them in the comments section.
