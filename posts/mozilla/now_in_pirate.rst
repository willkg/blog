.. title: SUMO: Now ... in pirate!
.. slug: now_in_pirate
.. date: 2013-02-08 13:30:00
.. tags: mozilla, work, sumo, dev


A while back, I wrote :doc:`a post about poxx.py
<miro4_in_swedish_chef>` which talked about a script
I based on `Ned Batchelder's poxx.py script
<http://nedbatchelder.com/blog/201012/faked_translations_poxxpy.html>`_
and overhauled to provide a faux "Swedish Chef" translation of Miro strings
allowing me to test localizations of the application.

The transform from English to "Swedish Chef" had the following four
impotant properties:

1. the output is vaguely readable
2. the output is longer than the input which helps us find ui issues
3. the output is clearly distinguished from English which helps us find
   strings that aren't getting translated
4. the output is mildly amusing which is sometimes important in dark
   times

Back in August, I made some changes and pulled it into `Fjord
<https://github.com/mozilla/fjord>`_. This helped us suss out localization
issues on a new site. However, I wasn't really happy with it. Amongst
other things, it always felt like "Swedish Chef" was culturally
insensitive.

A couple of weeks ago, I overhauled poxx.py again. This time, PIRATE!
It continues to have the four properties I think are important for a
test locale.

We're using it now for `SUMO <http://support.mozilla.org/>`_ development.
It's the grog to your Jolly Roger:

.. thumbnail:: /images/sumo-pirate.png

   SUMO -- In Pirate!


We're using this script on both SUMO and Fjord now. You can use it for your
site, too! The code is at `<https://github.com/mozilla/kitsune/tree/master/scripts/>`_.

If you see any problems with it, toss me a message in a bottle.

.. Note::

   This localization is **only** available in development environments.
   Unlike Miro where we shipped the Swedish Chef translation (or used to---I'm
   not sure if they do anymore), you cannot see this on the -dev, -stage or
   -prod SUMO sites.
