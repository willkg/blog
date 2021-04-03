.. title: Firefox 3 enclosure support: retrospective (2008)
.. slug: firefox3_enclosures
.. date: 2008-02-21 13:40:27
.. tags: miro, work, dev, story, retrospective

A little under two weeks ago patches for bugs :bz:`303645`, :bz:`400061`, and
:bz:`400064` landed in the Firefox trunk. These patches add video/audio
podcast-related enhancements to the upcoming Firefox 3. Firefox 3’s feed
preview page now distinguishes video and audio podcast feeds from “regular
feeds”. It will also show all enclosures in the feed with information about the
enclosure.

It’s really exciting for these features to be in Firefox 3. These enhancements
reduce the interface divide between Firefox and video/audio podcast consuming
applications like `Miro <https://getmiro.com>`_, iTunes, and others. Amongst
other things, it’s hugely beneficial to Miro users who use Firefox.

Here’s what the feed preview page looks like in Firefox 2 on Ubuntu Gutsy:

.. thumbnail:: /images/firefox_2_before.png

   Feed preview page in Firefox 2

Here’s what the feed preview page will look like in Firefox 3 on Ubuntu Gutsy:

.. thumbnail:: /images/firefox_3_after.png

   Feed preview page in Firefox 3

I’m really excited that this is going in. At a bare minimum, it means I have to
spend a lot less time fishing through view source finding enclosures.

This is my first contribution to Firefox and my first time working with Mozilla
developers and other Firefox contributors. There was a lot of material to come
up to speed on including build process, testing procedures, who’s in charge of
what, getting reviews done, etc.

I want to give a shout out to Mike Beltzner who was really patient and
incredibly helpful in getting the functionality landed. Also to Robert Sayre
and Myk Melez who reviewed the code and suggested changes and fixes that made
it much better. Also to Alex Faaborg who kicked off this mini-project back in
October. And lastly all the people on #developers on IRC who helped me with
issues I was having: Ventnor, biese, bz, gavin, Pike, _FrnchFrgg_ and
others--thank you all!

It was neat in that the patches landed just before the beta 3 codefreeze on my
birthday.
