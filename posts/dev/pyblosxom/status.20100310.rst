.. title: PyBlosxom status: 03/10/2010
.. slug: status.20100310
.. date: 2010-03-10 12:48:44
.. tags: pyblosxom, dev

PyBlosxom 1.5 rc1 was released a month or so ago.  Since then I haven't
had much time to finish things up.

Spaetz kindly did the work to move PyBlosxom source code from svn on SourceForge
to git on Gitorious.  The plan is to move development to Gitorious and the 
web-site, documentation, bug-tracking, and things like that to a site on my
server bluesock.org.

This enables people to fork PyBlosxom trivially and make the changes they 
need to make to get PyBlosxom working for them.  This will result in more 
experimentation and work being done and reduce the problem of me and my 
decision making being a bottle neck in future PyBlosxom development.

The other big change that's happening partially in the PyBlosxom 1.5 timeframe
and partially in future versions is the ecology for plugins.  Previously, I
ignored them and spent my time on PyBlosxom core stuff.  Ryan was maintaining
the plugins, but the infrastructure we had for plugin maintenance sucked.
Going forward, plugins will fall into two categories:

* Maintained plugins will be in the plugins/ directory of the pyblosxom tarball.
  These plugins will have unit tests and will be versioned alongside PyBlosxom.
* Plugins maintained by other people will be indexed on the website in a
  registry, but one that will suck less than the current plugin registry.

The plugins that are currently in the contributed plugins pack will be split
into those two groups.

PyBlosxom 1.5 is waiting on some more documentation changes, some more plugins
work, and now some project infrastructure changes.  I'll probably do another
release candidate soon and suggest people start using that.

If you're interested in helping out, come hang out on IRC on freenode.net in the
#pyblosxom channel.  The conversations have been interesting over the last
couple of months and have been instrumental in work getting done.
