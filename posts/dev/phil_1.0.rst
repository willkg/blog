.. title: phil 1.0 released!
.. slug: phil_1.0
.. date: 2011-12-03 17:29:38
.. tags: python, dev, mediagoblin, phil

`Mediagoblin <http://mediagoblin.org>`_ has monthly project meetings.  One
of the things I wanted to automate was meeting reminders that gets sent
x days in advance, contain the link to the Meetings page in the wiki, and
specify the date and time of the next meeting.  I figure if we automate
it, it's one less thing we have to think about---it just happens.

To do this, I decided to write `phil <http://github.com/willkg/phil>`_.
For the most part, it's sort of a throw-away project, but it was so small
that I decided to go through a complete project development cycle with it
and make sure it had all the bits a mature Python project should have:
proper packaging, license, configuration, tests, project infrastructure, ...

I think it took about 10 hours over the course of 2 weeks.  I was learning
the icalendar library and python-dateutil and also figuring out exactly
what I wanted it to do as I went along.  For a small project like this,
that's fine.  For a larger project, I'd prefer to spend more time researching
and designing ahead of time.

It was nice to "take a vacation" and put all the other projects I normally
work on on hold to throw something together from scratch.

* Github page: https://github.com/willkg/phil
* PyPI page: http://pypi.python.org/pypi/phil
