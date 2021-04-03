.. title: Hardy tips for resolution fixing when using it in a VirtualBox vm
.. slug: ubuntu_hardy
.. date: 2008-04-19 18:45:57
.. tags: computers, ubuntu, miro

I'm trying to get Ubuntu Hardy support for Miro.  I installed Hardy Beta 1 
in a virtual machine with VirtualBox.  The install went fine.  I had problems
fixing the resolution, though.

Hardy starts off with an 800x600 resolution which is too small to run Miro.
To fix it, you have to:

* run ``sudo displayconfig-gtk`` from a terminal
* click on the dropdown for models and choose *LCD Panel 1024x768*
* click on the *Test* button to make sure it works
* click on the *OK* button to apply that one change
* log off
* log on again

**DON'T** change the monitor AND the resolution of the screen at the same time.
If you do that, you see no errors, no changes get made, and you'll spend a while
scratching your head wondering what happened.

If all went well, you should see the resolution you were looking for.

Note that since Ubuntu Hardy is beta software, this could all change tomorrow.

**Update:**

4/19/2008: It looks like they took displayconfig-gtk out of the
menus in the Hardy release candidate so I updated the instructions above.
