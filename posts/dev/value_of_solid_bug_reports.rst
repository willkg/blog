.. title: The value of solid bug reports
.. slug: value_of_solid_bug_reports
.. date: 2006-02-06 16:14:00
.. tags: dev

I admit that "solid bug report" is vague and probably different
depending on the nature of the bug being reported.  However, the
amount of time it takes to research and fix a bug that has a
well-written bug report vs. the time it takes to research and fix
a bug that has a craptastic bug report is orders of magnitude
in difference.  In some cases, the latter bug report doesn't shed
any light on the issue at all and thus won't result in a fix in any
amount of time.

Anyhow, many many many thanks to Joey Hess to submitted a bug report
in the Debian bug system (passed on to me by Norbert) regarding a
problem with static rendering.  He provided a wealth of information
including his whole setup via subversion.  He gets ten gold stars.

On a side note while I'm kvetching, I dislike bug reports that 
include a patch but don't specify what the problem is and why the
patch is a good fix for the problem.  It seems silly...  you'd think
I could look at the patch and work backwards to figure out what the
issue is, but that is rarely the case.  Often people who are providing
the patches don't really understand what's going on at that point in
the code and they've created a patch that "makes the problem go away
for them" which is really different than "fixes the problem".
