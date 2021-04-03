.. title: Bleach: stepping down as maintainer
.. slug: bleach_stepping_down
.. date: 2019-03-01 9:00
.. tags: python, dev, bleach, mozilla, story

What is it?
===========

`Bleach <https://bleach.readthedocs.io/>`_ is a Python library for sanitizing
and linkifying text from untrusted sources for safe usage in HTML.


I'm stepping down
=================

In October 2015, I had a conversation with James Socol that resulted in me
picking up Bleach maintenance from him. That was a little over 3 years ago.
In that time, I:

* did 12 releases
* improved the tests; switched from nose to pytest, added test coverage
  for all supported versions of Python and html5lib, added regression
  tests for xss strings in OWASP Testing Guide 4.0 appendix
* worked with Greg to add browser testing for cleaned strings
* improved documentation; added docstrings, added lots of examples, added
  automated testing of examples, improved copy
* worked with Jannis to implement a security bug disclosure policy
* improved performance (:doc:`Bleach v2.0 released! <bleach_2_0>`)
* switched to semver so the version number was more meaningful
* did a rewrite to work with the extensive html5lib API changes
* spent a couple of years dealing with the regressions from the rewrite
* stepped up as maintainer for html5lib and did a 1.0 release
* added support for Python 3.6 and 3.7

I accomplished a lot.


A retrospective on OSS project maintenance
==========================================

I'm really proud of the work I did on Bleach. I took a great project and moved
it forward in important and meaningful ways. Bleach is used by a ton of
projects in the Python ecosystem. You have likely benefitted from my toil.

While I used Bleach on projects like SUMO and Input years ago, I wasn't really
using Bleach on anything while I was a maintainer. I picked up maintenance of
the project because I was familiar with it, James really wanted to step down,
and Mozilla was using it on a bunch of sites--I picked it up because I felt an
obligation to make sure it didn't drop on the floor and I knew I could do it.

I never really *liked* working on Bleach. The problem domain is a total
fucking pain-in-the-ass. Parsing HTML like a browser--oh, but not exactly like
a browser because we want the output of parsing to be as much like the input as
possible, but as safe. Plus, have you *seen* XSS attack strings? Holy moly! Ugh!

Anyhow, so I did a bunch of work on a project I don't really use, but felt
obligated to make sure it didn't fall on the floor, that has a pain-in-the-ass
problem domain. I did that for 3+ years.

Recently, I had a conversation with Osmose that made me rethink that. Why am I
spending my time and energy on this?

Does it further my career? I don't think so. Time will tell, I suppose.

Does it get me fame and glory? No.

Am I learning while working on this? I learned a lot about HTML parsing. I have
scars. It's so nuts what browsers are doing.

Is it a community through which I'm meeting other people and creating
friendships? Sort of. I like working with James, Jannis, and Greg. But I
interact and work with them on non-Bleach things, too, so Bleach doesn't help
here.

Am I getting paid to work on it? Not really. I did some of the work on
work-time, but I should have been using that time to improve my skills and
my career. So, yes, I spent some work-time on it, but it's not a project I've
been tasked with to work on. For the record, I work on
`Socorro <https://github.com/mozilla-services/socorro>`_ which is the
`Mozilla crash-ingestion pipeline <https://crash-stats.mozilla.org/>`_. I
don't use Bleach on that.

Do I like working on it? No.

Seems like I shouldn't be working on it anymore.

I moved Bleach forward significantly. I did a great job. I don't have any
half-finished things to do. It's at a good stopping point. It's a good time to
thank everyone and get off the stage.


What happens to Bleach?
=======================

I'm stepping down without working on what comes next. I think Greg is going to
figure that out.


Thank you!
==========

Jannis was a co-maintainer at the beginning because I didn't want to maintain
it alone. Jannis stepped down and Greg joined. Both Jannis and Greg were a
tremendous help and fantastic people to work with. Thank you!

Sam Snedders helped me figure out a ton of stuff with how Bleach interacts
with html5lib. Sam was kind enough to deputize me as a temporary html5lib
maintainer to get 1.0 out the door. I really appreciated Sam putting faith
in me. Conversations about the particulars of HTML parsing--I'll miss those.
Thank you!

While James wasn't maintaining Bleach anymore, he always took the time to answer
questions I had. His historical knowledge, guidance, and thoughtfulness were
crucial. James was my manager for a while. I miss him. Thank you!

There were a handful of people who contributed patches, too. Thank you!


Thank your maintainers!
=======================

My experience from 20 years of OSS projects is that many people are in similar
situations: continuing to maintain something because of internal obligations
long after they're getting any value from the project.

Take care of the maintainers of the projects you use! You can't thank them
enough for their time, their energy, their diligence, their help! Not just the
big successful projects, but also the one-person projects, too.


Shout-out for PyCon 2019 maintainers summit
===========================================

Sumana mentioned that `PyCon 2019 has a maintainers summit
<https://us.pycon.org/2019/hatchery/maintainers/>`_. That looks fantastic! If
you're in the doldrums of maintaining an OSS project, definitely go if you can.


Changes to this blog post
=========================

**Update March 2, 2019:** I completely forgot to thank Sam Snedders which is a
really horrible omission. Sam's the best!
