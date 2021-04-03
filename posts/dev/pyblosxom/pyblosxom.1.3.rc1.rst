.. title: PyBlosxom 1.3 RC1 released!
.. slug: pyblosxom.1.3.rc1
.. date: 2006-01-02 17:40:34
.. tags: pyblosxom, dev, python

I'm releasing PyBlosxom 1.3 release candidate 1.  w00t!  A lot of work has
gone into this and it's taken way way way too long to finally get it out. My
apologies to everyone who's been waiting and such.

**Changes between 1.2 and 1.3**

*Pertinent to users:*

* We added a "blog_rights" property.  This holds a textual description
  of the rights you give to others who read your blog.  Leaving this
  blank or not filling it in will affect the RSS 2.0 and ATOM 1.0
  feeds.
* If you set "flavourdir" in your config.py file, you have to put
  your flavour files in that directory tree.  If you don't set
  "flavourdir", then PyBlosxom expects to find your flavour files
  in your "datadir".

  The flavour overhaul is backwards compatible with previous PyBlosxom
  versions.  So if you want to upgrade your blog, but don't want to
  move your flavour files to a new directory, DON'T set your "flavourdir"
  property.
* Moved the content that was in README to CHANGELOG.
* You can now organize the directory hierarchy of your blog by date.
  For example, you could create a category for each year and put
  posts for that year in that year (2003, 2004, 2005, ...).  Previously
  URLs requesting "2003", "2004", ... would get parsed as dates and
  would pull blog entries by mtime and not by category.</p>
* Logging works now.  The following configuration properties are
  useful for determining whether events in PyBlosxom are logged and
  what will get logged:
   
  * "log_file" - the file that PyBlosxom events will be logged to--the
    web-server MUST be able to write to this file.
  * "log_level" - the level of events to write to the log.  options are
    "critical", "error", "warning", "info", and "debug"
  * "log_filter" - the list of channels that should have messages logged.
    if you set the log_filter and omit "root", then app-level
    messages are not logged.

  It's likely you'll want to set log_file and log_level and that's it.
  Omit log_file and logging will fall back to stderr which usually gets
  logged to your web-server's error log.

*Pertinent to developers and plugin developers:*

Nothing that I know of.  Everything should work pretty much the same.


**Download, comments, et al**

Download it at `<http://www.bluesock.org/~willkg/download/>`_.

It's been locally tested (my blog has been running the version in CVS for
over a month now), but not globally tested.  While I'm pretty confident that
it should be ok for most people, I'm sure there are some issues that have
fallen through the cracks of our total lack of regression testing and unit
testing environment.

As such, I heartily encourage anyone still using PyBlosxom to set it up
locally and run it through the steps that your blog entails and let me know
this week whether there are any issues.

If I don't hear from anyone by Saturday, I'll just release it at my leisure.


**The future**

This is it for me.  This release fixes a bunch of flavour issues that needed
fixing.  It also includes a much better version of the manual and some work
has gone into making it more Python-standards compliant.

Over the last 9 months, the world of web-application development and Python
web-application development has changed radically.  I'm a little tempted to
re-write PyBlosxom using Paste, but I don't think it really helps our
"typical user" much and I'm not sure it makes sense given that there are a
variety of other weblog applications out there that are well-established and
have more momentum.

As such, I'll be helping with minor bug fixes and that's it.

Happy new year!
