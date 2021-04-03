.. title: PyBlosxom status: 02/10/2008 and GHOP thanks!
.. slug: status.02102008
.. date: 2008-02-10 19:08:18
.. tags: python, pyblosxom, dev

I overhauled the PyBlosxom web-site so that it's now being statically
"compiled" using PyBlosxom's static renderer.  The whole thing is
checked into SVN, too.  That's a huge improvement from the previous
situation, but the web-site could use user-interface and navigational 
work.

In doing that, I did a lot of futzing with static rendering using 
the code in trunk and fixed some issues.  I also thought through the
filelist implementation and re-worked it so that it handles sorting
and truncating better.  The results are really nice and I think it
fixes all the major problems previous versions had.

GHOP was a big help.  PyBlosxom had several tasks that were worked on
and the results speak for themselves:

* `Testing plugins #1 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=141>`_: 
  testing comments, comment-openid, nospam or spamquestion: completed by klossalex
* `Testing plugins #2 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=142>`_:
  testing pyguest, weblog-add, tags: completed by CanadaBear
* `Testing plugins #3 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=143>`_:
  testing filter, latest, autoping: darkmessenger88
* `Testing plugins #4 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=144>`_:
  testing pycategories, pygallery, contact: completed by CanadaBear
* `Memory footprint <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=224>`_:
  investigate memory footprint of PyBlosxom: completed by josiahw
* `Writing plugin #1 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=263>`_:
  write a new entry cache plugin using pickle for PyBlosxom 2.0: completed by jdzolonga
* `Writing plugin #2 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=264>`_:
  write a new entry cache plugin using shelve for PyBlosxom 2.0: completed by jdzolonga
* `Writing plugin #3 <http://code.google.com/p/google-highly-open-participation-psf/issues/detail?id=265>`_:
  write a new rst formatter plugin for PyBlosxom 2.0: completed by cracka80

It was a huge help that these people did for PyBlosxom.  I haven't fully 
absorbed their work yet, but it should happen before PyBlosxom 2.0 is
released.  Many thanks to those of you who helped out and many many
thanks to Google and the GHOP, PSF, Titus, Doug, Georg, Leslie and all the 
others who helped make this possible.  Thank you!

There are a few big things that still need to be done for PyBlosxom 2.0.
I'm moving through it slowly and methodically.  I was hoping to have it done
by the end of December, but I'm thinking now it's going to be the end of
March or thereabouts.
