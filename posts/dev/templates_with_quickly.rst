.. title: Building templates for Quickly and new webber-app template
.. slug: templates_with_quickly
.. date: 2010-04-29 16:12:50
.. tags: dev, python, web, ubuntu

`Quickly <https://wiki.ubuntu.com/Quickly>`_ is an
application that makes it easier to start new software development
projects by filling in a lot of the skeletal structure from a set of
templates.  I've read about it a bunch
on `Jono's blog <http://www.jonobacon.org/category/opportunistic-developers/>`_
in the context of his push for "opportunistic developers".

`Chris Webber <http://dustycloud.org/>`_ and I have been
throwing together web applications most of which have the same basic
structure: WebOb, Jinja2, simplejson, and routes with some glue and
stuff in between.

I spent some time building a Quickly template for this structure.
The results of this are
`quickly-webber-app <http://gitorious.org/quickly-webber-app>`_.

It was hard.  There's no docmentation that I
could find on creating templates for Quickly, so I had to look
through the ubuntu-project template and read through the Quickly
code.  Even then, I bumped into a few gotchas.

* the command scripts are run as scripts and not imported as Python
  modules
* command scripts must be executable, otherwise Quickly silently 
  skips them when building its commands list
* probably better to develop the template in
  your ``~/quickly-templates/`` directory rather than as a
  project and schlepping things in and out like I did

I was using the Quickly that comes with Ubuntu Karmic which is
0.2.6.  Ubuntu Lucid has a newer version, but I didn't want to
fiddle with trying to get it to install on Karmic given that it's
got dependencies that aren't readily available in Karmic.

After talking with Chris, he suggested I redo it with Paste
templates.  There's a good explanation
at `<http://pylonshq.com/docs/en/0.9.7/advanced_pylons/creating_paste_templates/>`_.
It'd be interesting to see if I could build a set of templates that
works with both Quickly and Paste.

Anyhow, the project is there if it's interesting to anyone.  Email
me or comment below if you have questions, comments, concerns, whatever.

**Updates:**

5/2/2010 - Didier (Quickly dev) says there is documentation for creating
templates at
`<http://www.didrocks.fr/index.php/post/Build-your-application-quickly-with-Quickly%3A-Inside-Quickly-part-6>`_.
