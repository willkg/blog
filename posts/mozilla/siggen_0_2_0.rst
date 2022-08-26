.. title: Siggen (Socorro signature generator) v0.2.0 released!
.. slug: siggen_0_2_0
.. date: 2018-08-29 12:00
.. tags: mozilla, work, socorro, python, dev, story

Siggen
======

`Siggen (sig-gen) <https://github.com/willkg/socorro-siggen>`_ is a Socorro-style
signature generator extracted from Socorro and packaged with pretty bows and
wrapping paper in a Python library. Siggen generates Socorro-style signatures
from your crash data making it easier for you to bucket your crash data using
the same buckets that Socorro uses.


The story
=========

Back in June of 2017, the signature generation code was deeply embedded in
Socorro's processor. I spent a couple of weeks extracting it and adding
tooling so as to:

1. make it easier for others to make and test signature generation changes
2. make it easier for me to review signature generation changes
3. make it easier to experiment with algorithm changes and understand
   how it affects existing signatures
4. make it easier for other groups to use with their crash data

I wrote a :doc:`blog post about extracting signature generation
<socorro_signature_generation>`. That project went really well
and as a result, we've made many big changes to signature generation with
full confidence about how they would affect things. I claim this was a big
success.

The fourth item in that list was a "hope", but wasn't meaningfully true.
While it was theoretically possible, because while the code was in its own
Python module, it was still all tied up with the rest of Socorro and
effectively impossible for other people to use.

A year passed....

Early this summer, Will Lachance took on Ben Wu as an intern to look at
Telemetry crash ping data. One of the things Ben wanted to do was generate
Socorro-style signatures from the data. Then we could do analysis on
crash ping data using Telemetry tools and then do deep dives on specific
crashes in Socorro.

I forked the Socorro signature generation code and created Siggen and
`released it on PyPI <https://pypi.org/project/siggen>`_. Ben and I
fixed some really rough edges and did a few releases. We documented
parts of signature generation that had never been documented before.

Ben wrote some symbolication code to convert the frames to symbols,
then ran that through Siggen to generate a Socorro style signature.
That's in `fix-crash-sig <https://github.com/Ben-Wu/fx-crash-sig>`_.
He did some great things with his internship project!

So then I had this problem where I had two very different versions of
Socorro's signature generation code. I did several passes at unifying
the two versions and fixing both sides so the code worked inside of
Socorro as well as outside of Socorro. It was effectively a rewrite
of the code.

The result of that work is `Siggen v0.2.0 <https://pypi.org/project/siggen/0.2.0/>`_.


Usage
=====

Siggen can be installed using ``pip``::

    $ pip install siggen

Siggen comes with two command line tools.

You can generate a signature from crash data on Socorro given
crashids::

    $ signature <CRASHID> [<CRASHID> ...]

This is the same as doing ``socorro-cmd signature`` in the Socorro local
development environment.

You can also generate a signature from crash data in JSON format::

    $ signify <JSONFILE>

You can use it as a library in your Python code:

.. code:: python

   from siggen.generator import SignatureGenerator

   generator = SignatureGenerator()

   crash_data = {
       ...
   }

   ret = generator.generate(crash_data)
   print(ret['signature'])

The schema is "documented" in the README which can be viewed online
at `<https://github.com/willkg/socorro-siggen#crash-data-schema>`_.

There's more Siggen documentation in the `README
<https://github.com/willkg/socorro-siggen>`_
though that's one area where this project is sort of lacking. There's
also more documentation about the signature generation algorithm in
`the Socorro docs on signature generation
<https://socorro.readthedocs.io/en/latest/signaturegeneration.html>`_.


What's the future of this library
=================================

This is alpha-quality software. It's possible the command line tools and
API bits will change as people use it and issues pop up. Having said that,
it's in use in a couple of places now, so it probably won't change much.

Some people want different kinds of signature generation. That's cool--this
neither helps nor hinders that.

This doesn't solve everyone's Socorro signature generation problems, but
I think it gives us a starting point for some of them and it was a doable
first step.

Some people want to produce Socorro-style signatures from their crash data.
This will help with that. Unless you need the code in some other language
in which case this is probably not helpful.

I wrote some tools to update Siggen from changes in Socorro. That was how I
built v0.2.0. I think that worked well and it's pretty easy to do, so I
plan to keep this going for a while.

If you use this library, please tell me where you're using it. That's how I'll
know it's being used and that the time and effort to maintain it are worth
while. Even better, add a star in GitHub so I have a list of you all and can
contact you later. Plus it's a (terrible) indicator of library popularity.

If no one uses this library or if no one tells me (I can't tell the
difference), then I'll probably stop maintaining it.

If there's interest in this algorithm, but implemented with a different
language, please let me know. I'm interested in helping to build a version in
Rust. Possibly other languages.

If there's interest in throwing a webapp with an API around this, chime
in with specifics in :bz:`828452`.

Hopefully this helps. If so, let me know! If not, let me know!
