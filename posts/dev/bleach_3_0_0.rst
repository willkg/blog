.. title: Bleach v3.0.0 released!
.. slug: bleach_3_0_0
.. date: 2018-10-03 12:00
.. tags: python, dev, bleach, mozilla, story

What is it?
===========

`Bleach <https://bleach.readthedocs.io/>`_ is a Python library for sanitizing
and linkifying text from untrusted sources for safe usage in HTML.


Bleach v3.0.0 released!
=======================

Bleach 3.0.0 focused on easing the problems with the html5lib dependency and
fixing regressions created in the Bleach 2.0 rewrite

For the first, I vendored html5lib 1.0.1 into Bleach and wrote a shim module.
Bleach code uses things in the shim module which import things from html5lib.
In this way I:

1. keep the two separated to some extent
2. the shim is easy to test on its own
3. it shouldn't be too hard to update html5lib versions
4. we don't have to test Bleach against multiple versions of html5lib (which
   took a lot of time)
5. no one has to deal with Bleach requiring one version of html5lib and
   other libraries requiring other versions

I think this is a big win for all of us.

The second was tricky. The Bleach 2.0 rewrite changed clean and linkify
from running in the tokenizing step of HTML parsing to running after
parsing is done. The parser (un)helpfully would clean up the HTML before
passing it to Bleach. Because of that, the cleaned text would end up with
all this extra stuff.

For example, with Bleach 2.1.4, you'd have this:

>>> import bleach
>>> bleach.clean('This is terrible.<sarcasm>')
'This is terrible.&lt;sarcasm&gt;&lt;/sarcasm&gt;'


The tokenizer would parse out things that looked like HTML tags, the parser,
would see an end tag that didn't have a start tag and would add the start
tag, then ``clean`` would escape the start and end tags because they weren't
in the list of allowed tags. Blech.

Bleach 3.0.0 fixes that by tweaking the tokenizer to know about the list of
allowed tags. With this knowledge, it can see a start, end, or empty tag
and strip or escape it during tokenization. Then the parser doesn't try
to fix anything.

With Bleach 3.0.0, we get this:

>>> import bleach
>>> bleach.clean('This is terrible.<sarcasm>')
'This is terrible.&lt;sarcasm&gt;'


What I could use help with
==========================

I could use help with improving the documentation. I think it's dense and
all over the place focus-wise. I find it difficult to read.

If you're good with documentation, I sure could use your help. See
`issue 397 <https://github.com/mozilla/bleach/issues/397>`_ for more.


Where to go for more
====================

For more specifics on this release, see here:
https://bleach.readthedocs.io/en/latest/changes.html#version-3-0-0-october-3rd-2018

Documentation and quickstart here:
https://bleach.readthedocs.io/en/latest/

Source code and issue tracker here:
https://github.com/mozilla/bleach
