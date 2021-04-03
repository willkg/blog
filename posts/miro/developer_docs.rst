.. title: Better developer documentation for Miro
.. slug: developer_docs
.. date: 2009-07-09 16:20:22
.. tags: work, miro, python

During the Miro 2.5 development cycle, I've been working on getting
better developer documentation cobbled together. It's a huge task
that'll take us a while to do.

The initial focus of this developer documentation is two-fold:

#. provide web-based documentation for architecture, modules, classes,
   methods, functions, ...
#. codify project standard practices

This is important because it makes development easier for core
developers, but it's even more important because it'll make it easier
for casual contributors to figure out where everything is and how it
works.

This is in addition to the documentation found at the `Miro Development
Center <https://develop.participatoryculture.org/trac/democracy/wiki>`__
(aka our Trac wiki). Some content will move from the Miro Development
Center to the developer docs, but we'll have both for a long time to
come.

The first pass for developer documentation for Miro 2.5 is at
http://pculture.org/wguaraldi/miro/2.5/developer/. It answers such
questions as:

* how do I add support for a new search engine? (`see
  here <http://pculture.org/wguaraldi/miro/2.5/developer/searchengine_modules.html#how-to-add-a-search-engine>`__)
* how do I help translate Miro? (`see
  here <http://pculture.org/wguaraldi/miro/2.5/developer/translating.html#adding-a-new-translation>`__)
* where's all the database code? (`see
  here <http://pculture.org/wguaraldi/miro/2.5/developer/database_modules.html>`__)

There's a lot more to do, but it'll get better over time if people spend
time on it.

For those interested, I'm making heavy use of
`Sphinx <http://sphinx.pocoo.org/>`__. You can see the source from the
developer documentation by clicking on the "Show source" link on the
left hand side. The source for the documentation is in our svn tree at
https://develop.participatoryculture.org/trac/democracy/browser/trunk/docs/developer.
