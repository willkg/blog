.. title: Miro 4.0: now with swedish chef!
.. slug: miro4_in_swedish_chef
.. date: 2011-05-20 19:08:29
.. tags: miro, work

A while back, Ned Batchelder `wrote about poxx.py
<http://nedbatchelder.com/blog/201012/faked_translations_poxxpy.html>`_ 
which he wrote that generates a completely translated ``.po`` file to help
find strings in his apps that weren't being translated.

We on the Miro dev team had a similar need.  Additionally, we have the 
problem where in some languages, the translated string is longer than 
the English version and that creates some sizing issues in the ui code.

I took Ned's ``poxx.py``, fixed some issues I had with it, then rewrote
the transform to do something reminiscent of what the Swedish Chef would
say.  The transform has the following properties:

1. the output is vaguely readable
2. the output is longer than the input which helps us find ui issues
3. the output is clearly distinguished from English which helps us find
   strings that aren't getting translated
4. the output is mildly amusing which is sometimes important in dark
   times

I threw it together in an hour.  It's not a beautiful transform and it
doesn't add any "bork bork bork".  I might tweak it some rainy day.

It's in our git repository here:

https://git.participatoryculture.org/miro/tree/tv/resources/locale/poxx.py

It'll also be in Miro 4.0.  You can choose the Swedish Chef language
in the language dropdown in the Preferences dialog.  It's "swch" and
it'll be towards the bottom.

Also, skimming the comments of Ned's entry, there's another tool that
does this:

http://translate.sourceforge.net/wiki/toolkit/podebug
