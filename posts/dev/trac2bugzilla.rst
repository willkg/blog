.. title: Migrating tickets in Trac to bugs in Bugzilla
.. slug: trac2bugzilla
.. date: 2007-08-23 20:25:02
.. tags: dev, software

I spent a large portion of the last few weeks at PCF building 
a migration script to migrate tickets from our Trac instance to 
bugs in our Bugzilla instance.

I started writing SQL scripts, but then it got too hairy because
there are a bunch of Trac ticket fields that have no constraints
and translating them to Bugzilla equivalents required mappings and
temp tables ...  I abandoned that approach pretty quickly and 
wrote the migration script in Python.

The outcome of the migration is pretty decent.  We've spent time
fixing the data in Bugzilla after the migration, but I don't think
there's a way to do a perfect migration because of the nature of
the two bug systems.

I thought the project was interesting and mentioned it to a few
people.  The most common thing people respond with when hearing I 
was working on migrating our bug data from Trac to Bugzilla is, "What???  
WHY?!?!" and their eyes would open wide with shock.  I think Bugzilla 
has an undeserved bad rap.

The scripts are 
`here <https://develop.participatoryculture.org/trac/democracy/browser/trunk/resources/bugs>`_
if anyone else with similar plans is looking for them.

As a side note, the `Python Database API specification PEP <http://www.python.org/dev/peps/pep-0249/>`_
is fantastic--thank you to everyone who contributed to it!
