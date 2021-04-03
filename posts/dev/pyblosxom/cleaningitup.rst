.. title: Cleaning up PyBlosxom
.. slug: cleaningitup
.. date: 2006-07-19 13:48:44
.. tags: pyblosxom, dev, python

I've been following `Cheesecake <http://pycheesecake.org>`__
development with the hope that it'd be a tool that would help me
fix PyBlosxom's shortcomings, make it easier for people to use, and
make it easier for people to develop.  It has certainly been all 
that and more.

I've been going through the various kwalitee measures that Cheesecake 
does to understand them and I've been making adjustments to PyBlosxom's 
source code and project infrastructure.  I've made a lot of changes so
far, discovered some latent bugs and code problems, documented 
undocumented code, fixed existing documentation, and started writing
tests.

It's a huge effort, but it's a lot easier with tools like 
`Cheesecake <http://pycheesecake.org/>`__, 
`nose <http://somethingaboutorange.com/mrl/projects/nose/>`_,
`pylint <http://www.logilab.org/projects/pylint>`_, and
`coverage <http://www.nedbatchelder.com/code/modules/coverage.html>`_.
Additionally, the blog entries at 
`AgileTesting <http://agiletesting.blogspot.com/>`_ and 
articles at
`Living in an Ivory Basement <http://ivory.idyll.org/>`_ have
been helpful.  Also, I've been shamelessly copying the infrastructure
of the Cheesecake project.  That's made it a lot easier to get my head
around various bits.

At the moment, everything is local.  I'd start checking things in but
SVN at SF is really flakey (though the SF site status page doesn't mention
any SVN issues).

I see the next version of PyBlosxom having some bug fixes and new features,
but generally it's going to be a release focusing on cleaning up the
codebase and the infrastructure.

Out of curiosity, while I'm in the process of cleaning up the codebase
is it interesting to anyone for me to write up more detailed blog
entries covering up how and what I'm doing?  It might help by giving 
outlining a gameplan for cleaning up other Python-based projects.  If
that's something you're interested in, toss a comment on the blog or
email me at *willkg at bluesock dot org*.
