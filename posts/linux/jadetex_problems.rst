.. title: problems upgrading tetex-bin
.. slug: jadetex_problems
.. date: 2006-09-30 00:39:53
.. tags: computers, bluesock, debian

I went to update bluesock today and had wicked problems when it
tried to upgrade tetex-bin to version 3.0-18.  Every time it'd
try to configure tetex-bin, it'd fail with this::

   Setting up tetex-bin (3.0-18) ...
   Running fmtutil-sys. This may take some time... Error: `etex -ini  
   -jobname=jadetex -progname=jadetex &latex jadetex.ini' failed
   Error: `pdfetex -ini  -jobname=pdfjadetex -progname=pdfjadetex &p
   dflatex pdfjadetex.ini' failed


and lots of other output.

After futzing with things for a while I finally started skimming 
the Debian BTS and discovered 
`bug 334613 <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=334613>`_.
Towards the bottom, Frank says that he can reproduce the bug by having
jadetex installed before upgrading.

So I did an ``apt-get remove jadetex`` then an ``apt-get upgrade`` and
tetex-bin installed fine as did everything else.  Then I re-installed jadetex
and docbook-utils and my system is happy again.

Figured I'd mention it in case anyone else had the same problem.

**Update:**

Update: I have multiple systems: one desktop (running Ubuntu Dapper), 
one laptop (running Ubuntu Edgy), and one server that I lease from 
ServerBeach (running Debian Sid).  The jadetex problem I had was on 
the server running Debian Sid.  I have no idea if the same problem 
occurs on my Ubuntu boxen.  Figured I'd add that additional detail.
