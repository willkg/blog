.. title: Team Dragon: The Book
.. slug: teamdragon
.. date: 2009-12-02 23:39:57
.. tags: content, fun, life, python

Between the end of 2003 and mid-2007, I played in a D&D campaign that
was really fantastic. The campaign ran its course and our stalwart crew
of awesomeness saved the world and then we went our separate ways.

During that period of time, I kept copious notes in a MoinMoin wiki of
our adventures. It was always a hope that I'd take these notes and do
something with them.

I played in another campaign in 2007 and used
`InkScape <https://inkscape.org/>`__ to do `a comic of the first
session or two of that
campaign <https://dnd.bluesock.org/broadleaf_four/>`__ in the style of
`Order of the Stick <https://www.giantitp.com/comics/ootslatest.html>`__.
It was a lot of fun, but took forever to do each panel. I decided it'd
take me a long time to do 4 years worth of sessions in comic form.

So I started a book version. I wrote a Python script (which I've since
lost) that converted MoinMoin format into restructured text. Then I
threw the whole thing together with
`Sphinx <https://www.sphinx-doc.org/en/master/>`__. This allowed me to edit in
restructured text, compile a LaTeX document, and then generate a PDF
from that. Plus I got to spend some quality time with Sphinx to see how
well it generates manuals.

That worked really well except for some minor issues.

First, I needed to set the paper size in the resulting PDF. To do that,
I set the ``latex_preamble`` in the ``conf.py`` file to:

.. code-block:: python

   latex_preamble = '\\usepackage[papersize={6in,9in}]{geometry}\n' \
                    '\\setcounter{tocdepth}{1}'

That creates the PDF in the size I needed: 6in x 9in.

Second, I needed to fix some images so they were in a table with text. I
ended up writing the LaTeX for that by hand.

Third, I didn't think the chapter headings really fit with what I wanted
to build, so I changed the fncychap style to Lenny.

While I was editing the LaTeX directly, I ended up changing some of the
front matter and removed the index (didn't need an index to a novel).

It took me a year to put the book together. It's around 240 pages or so.
Today I finished it up, created a `Lulu <https://www.lulu.com/>`__
project for the book and had a bunch of copies printed for the others in
the group. Feels good to have that done. I'm looking forward to getting
a copy in the mail.
