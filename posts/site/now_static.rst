.. title: Blog update: October 11th, 2012
.. slug: now_static
.. date: 2012-10-11 13:49
.. tags: blog, pyblosxom


I spent the greater part of my free time over the last two weeks
reworking my blog.

Before it ran on `Pyblosxom <http://pyblosxom.github.com/>`_ as a CGI
process (yes---a CGI process). It had accrued a decade of sediment,
redirects, hacks, hacks on hacks, etc (yes---a decade). It was kind of
messy and---worse---it really impaired my ability to blog easily. That
sucked.

Now it runs on Pyblosxom, but it's statically rendered with a
post-receive hook from a git repository. The work flow for blogging is
a *lot* easier and I can test things out locally before pushing them
live. I also ditched a bunch of silly things in the blog.

I also ditched comments. I might at some point switch to using
something like `talka.tv <http://talka.tv/>`_, but most of the time
people were writing comments as a response or a reply to me---not
intending to be part of a bigger discussion with other readers. Given
that, I ditched comments. No sense in spending the time maintaining
them if they don't really get used. Instead, email me.
