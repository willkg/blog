.. title: status: week ending 12/25/2007
.. slug: status__week_ending_12_25_2007
.. date: 2007-12-23 11:25:36
.. tags: miro, work

Figured I'd send this out early because I'm not going to get anything
more accomplished.

I spent Wednesday, Thursday and Friday:

* triaging old bugs
* continuing to clean up comment spam left over from when our bug
  system was managed by Trac
* fixing my Windows build environment problem (`bug
  9327 <http://bugzilla.pculture.org/show_bug.cgi?id=9327>`__)
* fixing the problem with Miro on Windows in the 1.0 branch (`bug
  9363 <http://bugzilla.pculture.org/show_bug.cgi?id=9363>`__)
* checked in a fix from a downstream reported problem where Miro on
  GTKX11 doesn't honor the --xine-driver option (`bug
  9373 <http://bugzilla.pculture.org/show_bug.cgi?id=9373>`__, r5897,
  r5898)
* started making adjustments to our build scripts to allow us to tag
  with "Miro-1.1" instead of
  "Democracy-Player-With-White-Wine-Sauce-1.1" which is too long and
  I'm sick of typing it ;)
* set up a pbuilder environment for testing Ubuntu/Debian packages and
  continuing to make our packages better

That about covers the last three days.
`pbuilder <http://www.netfort.gr.jp/~dancer/software/pbuilder-doc/pbuilder-doc.html>`__
is really cool, but takes forever to run because it's building a fresh
environment in which ti build everything and it does that by downloading
and installing all the packages each iteration. It's definitely a good
idea to do this, though, as it'll increase the confidence in our
Ubuntu/Debian packaging and potentially fix outstanding issues.

I'm doing a whirlwind tour of family visiting over the next few days,
then going down to Louisiana on a service trip to rebuild houses. I'll
be back online January 1st.
