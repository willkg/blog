.. title: Code growth
.. slug: code_growth
.. date: 2010-06-01 15:01:53
.. tags: miro, work, dev

I was working on identifying and removing dead code in the Miro tree
today when I decided to do some stats on the Miro codebase over the last
bunch of versions.

+-----------------------+-----------------------+-----------------------+
| version               | sloccount             | .tar.gz size          |
+=======================+=======================+=======================+
| 1.0                   | ::                    | 12.3mb                |
|                       |                       |                       |
|                       |    python:            |                       |
|                       |        44700 (94.91%) |                       |
|                       |    cpp:               |                       |
|                       |          1313 (2.79%) |                       |
|                       |    ansic:             |                       |
|                       |           790 (1.68%) |                       |
|                       |    xml:               |                       |
|                       |           264 (0.56%) |                       |
|                       |    sh:                |                       |
|                       |            30 (0.06%) |                       |
+-----------------------+-----------------------+-----------------------+
| 1.1.2                 | ::                    | 13.4mb                |
|                       |                       |                       |
|                       |    cpp:               |                       |
|                       |        58403 (58.71%) |                       |
|                       |    python:            |                       |
|                       |        39985 (40.20%) |                       |
|                       |    ansic:             |                       |
|                       |           790 (0.79%) |                       |
|                       |    xml:               |                       |
|                       |           264 (0.27%) |                       |
|                       |    sh:                |                       |
|                       |            30 (0.03%) |                       |
+-----------------------+-----------------------+-----------------------+
| 1.2.8                 | ::                    | 14.6mb                |
|                       |                       |                       |
|                       |    cpp:               |                       |
|                       |        58491 (58.53%) |                       |
|                       |    python:            |                       |
|                       |        40187 (40.21%) |                       |
|                       |    ansic:             |                       |
|                       |           796 (0.80%) |                       |
|                       |    xml:               |                       |
|                       |           265 (0.27%) |                       |
|                       |    sh:                |                       |
|                       |           196 (0.20%) |                       |
+-----------------------+-----------------------+-----------------------+
| 2.0.5                 | ::                    | 7.3mb                 |
|                       |                       |                       |
|                       |    cpp:               |                       |
|                       |        73663 (58.74%) |                       |
|                       |    python:            |                       |
|                       |        49198 (39.23%) |                       |
|                       |    ansic:             |                       |
|                       |          1831 (1.46%) |                       |
|                       |    xml:               |                       |
|                       |           438 (0.35%) |                       |
|                       |    sh:                |                       |
|                       |           282 (0.22%) |                       |
+-----------------------+-----------------------+-----------------------+
| 2.5.4                 | ::                    | 10.0mb                |
|                       |                       |                       |
|                       |    cpp:               |                       |
|                       |        73808 (57.63%) |                       |
|                       |    python:            |                       |
|                       |        51631 (40.31%) |                       |
|                       |    ansic:             |                       |
|                       |          1874 (1.46%) |                       |
|                       |    xml:               |                       |
|                       |           432 (0.34%) |                       |
|                       |    sh:                |                       |
|                       |           328 (0.26%) |                       |
+-----------------------+-----------------------+-----------------------+
| 3.0.2                 | ::                    | 9.7mb                 |
|                       |                       |                       |
|                       |    python:            |                       |
|                       |        52869 (95.73%) |                       |
|                       |    cpp:               |                       |
|                       |           832 (1.51%) |                       |
|                       |    ansic:             |                       |
|                       |           692 (1.25%) |                       |
|                       |    xml:               |                       |
|                       |           432 (0.78%) |                       |
|                       |    sh:                |                       |
|                       |           403 (0.73%) |                       |
+-----------------------+-----------------------+-----------------------+
| git master            | ::                    | 9.6mb                 |
|                       |                       |                       |
|                       |    python:            |                       |
|                       |        53305 (95.98%) |                       |
|                       |    cpp:               |                       |
|                       |           832 (1.50%) |                       |
|                       |    ansic:             |                       |
|                       |           692 (1.25%) |                       |
|                       |    xml:               |                       |
|                       |           432 (0.78%) |                       |
|                       |    sh:                |                       |
|                       |           279 (0.50%) |                       |
+-----------------------+-----------------------+-----------------------+

There are a couple of interesting things here. First is that we switched
to libtorrent in Miro 1.1. We had libtorrent code in the tarball in Miro
1.1 and removed it in Miro 3.0--that's the bulk of the cpp code.

Second, we did a ui overhaul for Miro 2.0. In doing that, we switched
all three platforms to using gettext and thus only had to have one set
of translations. We also ditched a bunch of binary data. That reduced
the tarball size significantly.

Third, the number of lines of Python code has been going steadily up
since Miro 1.1. This is the number I'm most concerned with. In adding
more Python code version after version after version, we're adding more
complexity and a larger domain of things to test. This adds to the
maintenance work we have to do between versions, too.

We sure could use some help coding, fixing, maintaining, testing,
documenting and translating.
