.. title: Compiling the Tiger runtime for SPIM
.. slug: compiling_tiger_runtime_spim
.. date: 2007-04-23 18:39:37
.. tags: dev


I figured I'd post this because I just spent 24 hours trying to work
out the issues.

I'm in a compilers class that's using the 
`Modern Compiler Implementation in ML <http://www.cs.princeton.edu/~appel/modern/ml/>`_
book (aka the Tiger book) by Andrew Appel.
Over the course of the first 12 chapters, you build a compiler for a 
language called Tiger.  Appel has a runtime.c that you can download
from his web-site, but if you add functions to the runtime.c (for
example, we added a ternary string comparison function which made
string relops trivial to implement), then you need to compile
runtime.c into assembler that's SPIM-appropriate.


Long story short I've got a Gateway 450 something or other laptop (i686)
running Ubuntu Feisty Fawn and gcc version 4.1.2.  I used the
`crosstool <http://kegel.com/crosstool/>`_ scripts from
Dan Kegel.  I used the ``demo-mips.sh`` script, but modified it
to this:

.. code-block:: shell

   #!/bin/sh
   set -ex

   # Big-endian MIPS

   TARBALLS_DIR=$HOME/downloads
   RESULT_TOP=$HOME/mipsgcc
   export TARBALLS_DIR RESULT_TOP
   GCC_LANGUAGES="c"
   export GCC_LANGUAGES

   # Really, you should do the mkdir before running this,
   # and chown /opt/crosstool to yourself so you don't need to run as root.
   mkdir -p $RESULT_TOP

   # Build the toolchain.  Takes a couple hours and a couple gigabytes.

   eval `cat mips.dat gcc-3.4.5-glibc-2.3.5.dat`        sh all.sh --notest

   echo Done.


Ubuntu has ``/bin/sh`` point to dash--but this causes problems
when compiling glibc 
(`see here
<http://www.mail-archive.com/ptxdist@pengutronix.de/msg00240.html>`_).  So I
changed ``/bin/sh`` to point to bash instead of dash.  That fixes the ``error:
missing terminating " character`` error.

After you get your cross-compiler working, you can compile your
runtime.c into a runtime.s with something like this:

.. code-block:: shell

   % mips-unknown-linux-gnu-gcc -S -mrnames -mmips-as runtime.c -o runtime.s.raw


After that, you have to remove a few things so that it works in SPIM.
`Olin Shivers <http://www.ccs.neu.edu/home/shivers/csg262/runtime/>`_
has a page that talks about this some more.

Hopefully I included enough words in here that this pops up in searches
and helps future compiler-class takers in the same position I was in.
