.. title: Lyntin 4.0 beta 1 released
.. slug: release.4.0.beta1
.. date: 2003-09-18 21:10:24
.. tags: dev, lyntin, python

It's been a long time coming, but I keep getting bogged down in
other projects.  I'm only releasing a tar.gz file.  I wanted to
do a Windows installer, but I can't seem to get an installer that
builds a desktop shortcut.  I don't really want to keep throwing
time at it either.  So if you're inclined to tackle this issue,
let me know.

Things in this release:

* Added Python distutils support (will make packaging much much easier).
* Removed the Tintin eval mode and the idea of eval modes.
* Refactored hooks.  Hooks now pass around arguments in dicts rather
  than tuples--this is a big big change from 3.x.
* Split much of Lyntin's internal configuration into the constants
  module and the config module.
* Wrote a completely new configuration system.
* Overhauled ui's so that they'll work correctly.  This also makes it
  possible to write ui's in other widget systems.
* Split the substitutes module into substitutes and gags.
* Added a configuration ini file for setting boot options.
* Added tagged actions and also the ability for actions to trigger off of
  text with/without ansi colors removed.
* Fixed a bunch of bugs, some documentation updates (but not many), 
  and additional features here and there (most of which aren't documented
  yet--sorry everyone).

If you discover bugs or have other problems, let me know.  I'm on
vacation 9/24 through 9/30--so email sent will likely get queued until
I read it.

`Download here (.tar.gz) <http://www.bluesock.org/~willkg/lyntin/4.0/lyntin-4.0beta1.tar.gz>`_.

Rock on!
