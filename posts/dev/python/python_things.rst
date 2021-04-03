.. title: calendar, logger, pyblosxom!
.. slug: python_things
.. date: 2003-01-04 03:30:53
.. tags: dev, python, pyblosxom

I re-wrote my calendar utility (which tells me what my schedule
looks like when I log in) in Python.  This is good because I haven't
touched Perl in some time and I wanted to add some other formats
to it (like handling "second thursday" and "\*/15") and I wasn't
looking forward to figuring out what I wrote many years ago.

I also re-wrote my logger at work.  It's not really a logger--it's
more of a log extrapolator.  It takes all these fun bits and puts
them in places where I can glance over them quickly and guess at
what happened rather than reading all the gory details and know
enough to write a thesis.

Then I wanted to add a calendar to pyblosxom.  So I adjusted the
code to handle drop-in plugins and threw together a pycalendar
thingy.  It's not great but it works and it's not half-bad for
an hour of coding.
