.. title: fast and loose cloc stats for Miro
.. slug: fast_and_loose_cloc_stats_for_miro
.. date: 2008-07-03 14:24:33
.. tags: miro, work

Following `Paul's
lead <http://pculture.org/devblogs/paul/2008/07/03/some-quick-statistics-on-the-miro-guide-codebase/>`__,
here are some cloc stats for Miro in trunk:

::

   willg@mercury:~/pcf/miro/trunk/tv$ perl /home/willg/Desktop/cloc.pl .
       3468 text files.
   classified 3457 files
       1644 unique files.
       2763 files ignored.

   http://cloc.sourceforge.net v 1.04  T=20.0 s (35.2 files/s, 9438.1 lines/s)
   -------------------------------------------------------------------------------
   Language          files     blank   comment      code    scale   3rd gen. equiv
   -------------------------------------------------------------------------------
   Python              286      9689     10059     53376 x   4.20 =      224179.20
   C/C++ Header        265      7941     14412     31565 x   1.00 =       31565.00
   C++                  83      5474      4591     27832 x   1.51 =       42026.32
   C                     9      1159       889     13119 x   0.77 =       10101.63
   Javascript           17       420       557      2699 x   1.48 =        3994.52
   CSS                  11       391       476      2451 x   1.00 =        2451.00
   IDL                   7        18         0       486 x   3.80 =        1846.80
   XML                  13         2         3       275 x   1.90 =         522.50
   Bourne Shell          8       136       319       248 x   3.81 =         944.88
   make                  1         7         0        94 x   2.50 =         235.00
   HTML                  4         2         2        67 x   1.90 =         127.30
   DTD                   1         0         0         3 x   1.90 =           5.70
   -------------------------------------------------------------------------------
   SUM:                705     25239     31308    132215 x   2.41 =      317999.85
   -------------------------------------------------------------------------------
