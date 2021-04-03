.. title: Input status: June 19th, 2015
.. slug: input_status_20150619
.. date: 2015-06-19 15:00
.. tags: mozilla, work, dev, python, input

What is it?
===========

The purpose of `Input <https://input.mozilla.org/>`_ is to collect
actionable feedback from our user base across each channel of our
software development process. The application collects feedback and
offers a set of analysis methods for looking at the resulting data. 

`Project site <https://wiki.mozilla.org/Firefox/Input>`_.

This is a status post about Input.

.. TEASER_END
   

Development
===========

High-level summary:

* lots of library updates and changes to make way for Django 1.8
* switch from nose to pytest
* new suggests and redirector frameworks
* upgraded from Elasticsearch 0.90.10 to 1.2.4
* added editorconfig and pre-commit for easier development

That doesn't sound like a lot, but it was.

I'll write a more comprehensive blog post about the new suggests and
redirector frameworks soon.

Thank you to contributors!:

* L Guruprasad: 6
* Michael Kelly: 1
* Ricky Rosario: 17

Skipping the long list of commits and bugs. If you're interested, you
can check the commit logs.
  
Current head: ac406e4


Rough schedule going forward
============================

1. Finish up upgrade to Django 1.8.
2. Implement trigger-keyword provider.
3. Redo the Elasticsearch infrastructure in Fjord.

That's it for this update!
