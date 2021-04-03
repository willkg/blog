.. title: notes for remote control support for mirofullscreen on linux
.. slug: notes_for_remote_control_support_for_mirofullscreen_on_linux
.. date: 2009-03-26 15:20:31
.. tags: work, miro, python

I spent the greater part of today adding remote control support to the
Miro Fullscreen project. I thought I'd do a write up on it because there
are a lot of pieces involved and it took me ages to figure it out and
I'm paranoid I'll forget.

Quick caveats:

* I'm doing this on Ubuntu Intrepid (8.10). If you want to translate
  this to your favorite distribution, feel free to add any notes in the
  comments.
* If you're using OSX or Windows and want to know how to get things
  working there, I have no idea how to do it and that's not going to be
  covered here.
* I used a StreamZap remote and didn't try it with other remotes.
* This is a set of notes; it's not a good essay and I'm definitely not
  an expert.

**Requirements**

I installed three packages: ``lirc``, ``python-pylirc``, and
``gnome-lirc-properties``.

::

   sudo apt-get install lirc python-pylirc gnome-lirc-properties

**LIRC**

``lirc`` has a web-site at http://lirc.org/. I had no idea what I was
looking at while wandering aimlessly through that site. I think the
important pages are these:

* http://www.lirc.org/html/configure.html - covers the ``.lircrc`` file
  format
* http://lirc.sourceforge.net/remotes/streamzap/lircd.conf.streamzap -
  covers the codes for the StreamZap; there are other code pages at
  http://lirc.sourceforge.net/remotes/

**python-pylirc**

The only useful site I could find for this project was at
http://pylirc.mccabe.nu/. It says that Paul Hummer took over the project
and moved it to http://pylirc.ironlionsoftware.com/, but that's a dead
link. I found Paul's blog at http://theironlion.net/blog/. He uses
tagging on his blog, but there's only one article tagged as pylirc2 at
http://theironlion.net/tag/pylirc2/. I couldn't find anything useful
about pylirc, the project, its status, or what's going on. Paul suggests
he was going to add LIRC support to Entertainer, but it doesn't look
like he ever did that.

Anyhow, so I ended up going with the documentation on
http://pylirc.mccabe.nu/ and that seemed to work out ok.

**gnome-lirc-properties**

I don't know if I really needed ``gnome-lirc-properties``.

**The .lircrc file**

So you install the three (or two--depending on whether
gnome-lirc-properties is really needed) packages and you create a
``.lircrc`` file like this:

::

   begin
       prog   = mirofullscreen
       button = MUTE 
       config = n
   end
   begin
       prog   = mirofullscreen
       button = VOL_UP
       config = Up 
   end
   begin
       prog   = mirofullscreen
       button = VOL_DOWN
       config = Down 
   end
   begin
       prog   = mirofullscreen
       button = UP 
       config = Up 
   end
   ...

where *prog* is the string you pass to ``pylirc.init``, *button* comes
from the remote control lirc file and *config* is the string you add
handling for in your application.

**the Python code**

The sample code at
http://pylirc.mccabe.nu/?/article/articleview/Documentation/1426&themex=public
gave me enough of an idea on how it worked to implement the code in Miro
Fullscreen.

**In closing**

Hope that's useful to someone at some point.
