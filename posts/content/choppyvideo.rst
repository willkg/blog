.. title: Choppy video
.. slug: choppyvideo
.. date: 2005-05-29 12:29:41
.. tags: content, software

I have a Canon PowerShot S230 Digital Elph camera which has the almighty
power to record video in some encoding with AVI format. Playing these
videos works fine under Windows XP with Windows Media Player. However, I
had a heck of a time trying to get it to work with either MPlayer (as
it's distributed by Ubuntu Hoary) or Totem (as it's distributed by
Ubuntu Hoary). With MPlayer, I'd get some incomprehensible error, then
MPlayer would tell me to re-compile with the debugging information and
try it again, then die. Totem (the one with the gstreamer backend) would
play it, but it'd be really weird and choppy.

As a side note, in case this is useful to anyone, I have a system with
an AMD64-3200+, 1 GB of RAM, and various other exciting quantities of
exciting things running a mostly stock Ubuntu 05.04 though I am pulling
packages out of the universe. This wouldn't be much of an issue given
that I've got a machine running Windows XP with Windows Media Player
except that I'm switching my world over to run exclusively on GNU/Linux
and Open Source applications.

So armed with my observations, I did some poking around to at least get
a handle on what the pieces involved were. After 15 minutes of googling,
I found nothing that seemed to help. However, I did discover that
there's a version of Totem with a xine backend in the Ubuntu
repositories. So on a whim, I switched from the gstreamer Totem to the
xine one.

Now the video works fine. I figured I'd post this even though the
details I've written down couldn't be any less defined.
