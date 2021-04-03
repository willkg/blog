.. title: minor changes to hooks
.. slug: hooks2
.. date: 2002-11-20 22:26:06
.. tags: dev, lyntin, python

Just did some additional edits to the hooks which fix some potential
race condition problems between when Lyntin core hooks get instantiated 
and when they get registered with the HookManager.

Left to do:

* figure out if command parsing needs some attention in terms of
  unescaping characters
* get a help file from Josh on lyntin eval mode
* build a setup.py for distutils installation
* let the code bake a bit and testing
