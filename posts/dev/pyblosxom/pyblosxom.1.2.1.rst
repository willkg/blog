.. title: PyBlosxom 1.2.1 released
.. slug: pyblosxom.1.2.1
.. date: 2005-06-01 23:46:25
.. tags: python, dev, pyblosxom

This is a minor bugfix for PyBlosxom 1.2. If you use the conditionalhttp
plugin, you'll want to upgrade. Otherwise, it's not crucial.

Changes:

* Fixed a problem where the blosxom renderer never c hecked to see if
  it had already rendered the page. This affects the conditionalhttp
  plugin, but not much else.
* Removed an extra filestat.
* Added a setTimeLazy method to the FileEntry class.
