.. title: Thoughts on crowdsourcing development
.. slug: crowdsourcing
.. date: 2010-02-04 19:24:40
.. tags: dev, python, miro, work, gnome, floss, software


Today I read `You can't crowdsource software <http://hackervisions.org/?p=613>`_.
The title sums up what it's about.

I've had this experience with `Miro <http://getmiro.com/>`_.  We occassionally
get patches from non-PCF people but most of the work is done by `PCF
<http://pculture.org/>`_.  We've spent a lot of time and effort over the last
few years on getting more code contributors and reducing the barriers to entry.
We haven't had much success.

However, there's a lot of other "stuff" that goes into developing an application
and the article only focuses on code.  Some of this "stuff" can be
successfully crowdsourced without a lot of effort.  For example, Miro 
crowdsources all of our strings translation work through
`Launchpad <http://launchpad.net/>`_.

I work on another project called 
`PyBlosxom <http://pyblosxom.sourceforge.net/>`_.  We have a core group of
developers (right now this is me) who do the bulk of the core code work.  I do
some plugin work, but the bulk of the plugin work is done by users of PyBlosxom
many of whom have never touched the core code.  For PyBlosxom, plugin
development is crowdsourced.

The article suggests that it's a waste of time to help bring new contributors
come up to speed and contribute because they often don't contribute much.  That
conclusion really concerns me.  How can we get more people helping out if we're
not working on getting people to help out?

`Jono Bacon <http://www.jonobacon.org/>`_ wrote an article
titled `Project Awesome Opportunity <http://www.jonobacon.org/2010/02/04/project-awesome-opportunity/>`_
which talks about a few projects that are reducing the barriers to
contributing and making it a lot easier.  It's very Launchpad-centric,
though.

`OpenHatch <https://openhatch.org/>`_ is a startup working on 
building the next generation of contributors and connecting contributors
to projects that need help.  They're wrestling with how to effectively 
fix these problems, but without tying the fix to a project development
silo (e.g. Launchpad, GitHub, ...).  I think that's really important.

I think systems like these will reduce the effort in getting contributors
and make it easier to crowdsource code contribution.

And if you, dear reader, are looking for a project to help out on that's
written in Python and need someone to mentor you, let me know.

**Update:**

February 5th, 2010: I should clarify I think the article is fine.  I
don't think the conclusion that code contribution doesn't crowdsource well 
is poorly formed or anything like that.  Just that the implications aren't
great.
