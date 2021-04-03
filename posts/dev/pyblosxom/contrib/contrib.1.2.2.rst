.. title: Contributed plugins 1.2.2 released
.. slug: contrib.1.2.2
.. date: 2005-06-21 14:37:56
.. tags: python, pyblosxom, dev

This is the third release of the contributed plugins pack for PyBlosxom 1.2.

Here's the list of changes between contributed pack 1.2.1 and 1.2.2:

**General**

* New CHANGELOG.txt file which describes the changes between this version
  and the last as well as compatability and behavior issues.
* New README.txt file which describes what's in the contributed plugins
  pack, where you can find it, and various other things about the contributed
  plugins pack.

**genericwiki**

* Matej updated genericwiki so that it works as an entryparser as well as
  a preformatter.  Will fixed up the documentation.  genericwiki was moved
  from the preformatter directory to the entryparser directory.  Thanks Matej!

**pycategories**

* Now has two new properites "category_start" which gets printed once before 
  printing the category list and "category_finish" which gets printed once 
  after printing the category list.  Additionally, the default values for 
  "category_begin" and "category_end" were fixed.  This makes the default 
  output for pycategories (x)html compliant.  Thanks Joseph!

**comments**

* comments no longer shows comments by default!  In order to view comments
  for a given entry, you must append "showcomments=yes" to the querystring.
  THIS IS NOT A BACKWARDS-COMPATIBLE CHANGE!  Thanks David!

* comments no longer has documentation for the unused comments-rejected-words
  property.

* comments no longer requires the email field.

* all the flavour templates for the comments plugin have been updated.

* We cleaned up the comment error messages so they're useful to the user.
  Thanks Nathaniel!

**w3cdate**

* w3cdate plugin now provides $w3cdate in head and foot templates.  It no
  longer requires PyXML.  Thanks to Steven and Matej!


Thanks to Steven, David, Joseph, Matej, and Nathaniel for their contributions and
help.

If you find problems with contributed plugins, 
`visit this page on how to contact us <http://pyblosxom.sourceforge.net/blog/static/contact>`_
"Problems" could be bugs, feature-requests, or setup issues.

Find the contributed plugin pack 
`at contrib.1.2.2.tar.gz <http://sourceforge.net/project/showfiles.php?group_id=67445>`_.
