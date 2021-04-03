.. title: Comments and templates in PyBlosxom
.. slug: comments_and_templates
.. date: 2005-02-17 13:33:10
.. tags: pyblosxom, dev, python

A while back, I adjusted the comments plugin locally so that it would
allow me to have plugins that change the template type they use from
"story" to other things.  A couple of months ago, I sent Ted an email
with which pieces go in which templates.  Figured I'd stick that here
in case someone is looking for it.

This is only for the "story" section.  The head template goes before and the
foot template goes after this example.  This also only works with the
latest version of the comments plugin that has the template stomping
code removed.

::

   <div class="news">           <- story.html
   <h2>$title</h2>               |
   <div class="content">         |
   ...                           |
   </div>                        |
   links                         |
   </div>                       <-
   <div class="comments">       <- comment-story.html
   <div class="comment">        <- comment.html
   Posted by $blah at $blah      |
   $blah                         |
   </div>                       <-
   <div class="comment">        <- comment.html
   Posted by $blah at $blah      |
   $blah                         |
   </div>                       <-
   <div class="commentform">    <- comment-form.html
   form stuff here.              |
   </div>                        |
   </div>                       <-
