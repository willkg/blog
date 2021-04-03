.. title: XPath 2.0 implementations?
.. slug: xpath-2.0
.. date: 2007-04-13 15:13:36
.. tags: dev, xml

I've been looking around for implementations of XML Schema and XPath 2.0
so that I can test some things out for a research project I'm working on.
Essentially I need to be able to specify a schema in XSD, create an XML
document (or two or three) that conform to that schema and then I need
to be able to run a series of XPath 2.0 expressions on those XML documents.
An implementation that works in Java or Python is cool, but at this point
I'd even be willing to learn a new language to get something working.

In Java-land, the only XPath 2.0 implementation I can find is
`SAXON <http://saxon.sourceforge.net/>`_.  However, the "free" 
version, SAXON-B, isn't "schema-aware" (i.e. it doesn't have XML Schema 
handling in it).  The site says I can get an evaluation license...  but
I'm not really interested in evaluating SAXON--I just want to run some
tests to make sure my paper is accurate.

JAXB has an implementation of XML Schema.  JAXP 1.3 is in Java 1.5, 
JAXP 1.4 is in Java 1.6.  Both JAXP 1.3 and 1.4 have an implementation 
of XPath 1.0, but not 2.0 (which makes sense given that XPath 2.0 is 
pretty recent).

`Jaxen <http://jaxen.org/>`_ supports XPath 1.0, but not XPath 2.0.

I can't find anything else in Java-land.

In Python-land, there's `4suite <http://4suite.org/index.xhtml>`_
which has XPath 1.0 support, but doesn't seem to know anything about
XML Schema.  

There's `lxml <http://codespeak.net/lxml/>`_ which is a binding 
for `libxml2 <http://xmlsoft.org/>`_ which has support XML Schema 
(at least, it has support for XML Schema datatypes), but doesn't have an
XPath 2.0 implementation.  

There's also `Amara <http://uche.ogbuji.net/tech/4suite/amara/>`_,
but given the documentation talks about "node sets", I suspect it only 
implements XPath 1.0.  That's all I could find in Python-land.

My research is probably spotty.  I'm relying upon Google searches and what
I can garner from 20 minutes of skimming the project web-sites.  I've also
been using some loose heuristics to disambiguificate [1]_ usages
of "XPath" with no version number--when someone refers to "XPath" or 
mentions "node-sets", I assume they're probably talking about XPath 1.0.

Anyhow, any ideas on XPath 2.0 implementations that I missed?

.. [1] This is a word we used at ByAllAccounts often because it was amusing.
   There are other variations, too, such as disambiguificationalize.  This sort 
   of word bastardization makes documentation more interesting.
