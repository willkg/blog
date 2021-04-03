.. title: June 3rd chat -- follow-up and some more answers
.. slug: june_3rd_chat____follow_up_and_some_more_answers
.. date: 2008-06-04 11:23:40
.. tags: miro, work

I was the Q&A person for the `June 3rd
chat <http://www.getmiro.com/blog/2008/06/chat-with-miro-developer-today-430-edt-2130-utc/>`__
yesterday and I thought I'd post some follow-up and answer some of the
questions we didn't get to.

**Follow-up**

First off, I thought the chat went well and it was neat to talk to a
bunch of people I'd probably never talked to before. It seems that the
predominant theme was "when are features landing?" and "what's coming
up?" It's a little hard to answer those questions because I've been
pretty focused on the next release that I haven't been involved in
planning beyond that.

Now to answer some questions that we didn't have time for.

**How long have you worked for PCF? What did you do before Miro?**

I've been working at PCF since August 2007. This is in many ways my
dream job with my only issue being that I wished I either earned a bit
more money or had a lower cost of living. Other than that, I'm doing
what I love doing, I get to hang out with some really great people, and
the stuff we're working on is really important to me.

I'm going to assume "What did you do before Miro?" means "What did you
do before working at PCF?" Prior to PCF, I spent 2 years getting a
Masters at Northeastern University CCIS in programming language
design/theory and software engineering. Prior to that, I worked in the
financial services industry at ByAllAccounts, I worked as a contractor
for Tallan at Ingram Micro on their international web-site system, and
various other software developer positions before that. I've been
programming for probably 20 years now in various forms, but this is my
first FOSS job and the first job where I've worked with XULRunner and
GNU/Linux-stack components like Gtk+, GStreamer, Xine, Glade, DBus,
Glib, GObject, ... It's been great!

**shoestring: Video metadata: any plans to see miro actually writing it
to the files/being able to edit it?**

We've talked about making ui changes to allow for changing "metadata" of
content, specifically name, filename, tags, ... It hasn't happened yet,
though. I think it's one of many things waiting for the great widget
overhaul.

Miro can export feed information to OPML format, but this doesn't
include metadata about content. I don't know offhand if there are plans
to add that or not. There are plans on building an API to allow programs
like `MythTV <http://www.mythtv.org/>`__ and
`Elisa <http://elisa.fluendo.com/>`__ and other systems like that access
to Miro data. That hasn't happened yet, either. In this case, I think it
just needs someone to work on it.

**Evan: Is it possible to install miro without bittorrent? I know this
question is weird, but in some (many?) companies bittorrent is banned
... yet the company is ok with limited internet video usage.**

We don't have builds that don't have bittorrent in them. It would take
some work to decouple Miro from libtorrent and/or disable it and then it
sounds like we'd have to provide a separate set of libtorrent-less
builds. I don't think that's a bad idea, but I don't think it's going to
happen without a champion who can do the work.

**will: (seed question) What do you do when you're not working on
Miro-related things?**

A little silly answering my own seed questions, but ... so it goes.

Lately all I've been doing is Miro-related things. We're pushing really
hard on the next release. We're really excited about it and we think
it's another big milestone in Miro's life.

This year, I'm a backup admin for
`GSoC <http://code.google.com/soc/2008/>`__ for the
`PSF <http://www.python.org/psf/>`__ thought I haven't actually had to
do much (yet).

I've been trying to finish up work on version 2.0 of
`PyBlosxom <http://pyblosxom.sourceforge.net/>`__ for the last 6 months
but haven't found time and energy to get there. I've been able to make
some progress, but it seems to be on a permanent back-seat.

I'd really like to help `Mozilla <http://mozilla.org/>`__ on their
`embedding efforts <http://www.0xdeadbeef.com/weblog/?p=359>`__. I'd
also really like to get more involved in
`gstreamer <http://gstreamer.freedesktop.org/>`__, `Python
3000 <http://www.python.org/dev/peps/pep-3000/>`__ and a bunch of other
projects.

**Epilogue**

I think that's about it. Given that the chat went pretty well all things
considered, there will probably be another one in the future and
probably more after that.
