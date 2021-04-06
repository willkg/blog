.. title: Blog update: December 31st, 2013
.. slug: now_douglas
.. date: 2013-12-31 22:00
.. tags: blog, pyblosxom, douglas


A few weeks ago, a friend of mine started a site called `Nethack-a-day
<http://nethackaday.com/>`_.  It's fantastic---a Nethack game with
color commentary one turn at a time.  If you like Nethack, but haven't
seen it, you're missing out.

As he was setting it up, he was looking at various systems he could
build it with.  I sort of wanted to say, "Yo, just use Pyblosxom."
because I was pretty familiar with it (I spent the better part of 9
years maintaining it) and I knew it did 80% of what he needed.  But I
hesitated because I've been on the fence about switching to something
else for a while now.

Then I committed a critical mistake.  I said, "You know, Pyblosxom
would be great for this, but how about I fix a handful of things first
that'll make it easier to deal with."  A handful of things turned into
a massive overhaul of Pyblosxom ripping out a lot of the technical
debt that had been accruing for years, re-imagining some of the bits I
was never happy with and tweaking some things just because it seemed
like a good idea at the time.

Thus was born `Douglas <https://douglas.readthedocs.org>`_.

Douglas resembles many of the static site blog generator systems
written in Python that exist. That suggests it was a silly idea to go
and write it, but it has three compelling aspects that I think made it
worth my time:

1. It's derived from a blog system I maintained and thought about for
   a long time, so it has all the sorts of things I would want in a
   static blog generator

2. I can continue to say, "I've been using the same blog system since
   2002."  Sure, it's not *exactly* the same system, but it's not like
   I have to go rewrite/reformat entries I wrote in 2002.

3. It has a nicer callback system that I think makes it more malleable
   when it doesn't do exactly what you want by default.


Right now it's in an alpha state: the test suite doesn't cover enough
of the software; the docs are mediocre and in some cases are filled
with outright lies; there are a handful of issues; and there's still a
bunch of technical debt and some architectural decisions that sucked
and are increasingly difficult to work around.

Regardless, about a month, 102 commits and 9980 insertions and 22828
deletions later, I'm now switching my blog over to my new system.  And
that's how I'm going to end 2013.
