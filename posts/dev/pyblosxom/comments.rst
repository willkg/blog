.. title: comments plugin
.. slug: comments
.. date: 2004-09-24 17:06:16
.. tags: pyblosxom, dev, python

I'm going to spruce up the comments plugin that comes with PyBlosxom.
I'm going to merge the changes I've made locally with the contributed
version:

* Support for "blacklisted words" which, if they're in the comment, will
  cause the comment to be rejected
* Fix for the comment plugin so that instead of stomping on the template
  it now just appends the comment template to the story template.  This
  makes it play nice with other plugins.
* Change the behavior so that neither the comments nor the comment form
  show for an entry unless "showcomments=1" shows up in the querystring.
* Fixes to the logging.


I may incorporate the changes that 
`Jesus did <http://notreally.org/blog/devel/Python/pybloxsomnospam>`_
or at least figure out how to make that a plugin kind of thing.

Also, there should be a way to kick back messages to the user who just
did stuff with the comment form.  Then we can kick back messages when
comments are rejected and accepted for better usability.

**Updates:**

09-27-2004: Updated "John" to "Jesus"--I totally got his name wrong.  Oops.
