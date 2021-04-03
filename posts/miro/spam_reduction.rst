.. title: Reducing spam
.. slug: spam_reduction
.. date: 2011-04-25 21:15:30
.. tags: miro, work, wiki

We (PCF) have a MediaWiki instance that we use for a variety of PCF
projects. Since we set it up, we've been plagued with spam. The spam is
always exactly the same kind of thing: an account is created, an image
is uploaded, a new page is created with the image and a link to some
crap url.

.. thumbnail:: /images/recent_changes_before.png

   Before....

Over the last month, Asheesh and I fiddled with MediaWiki configuration
trying to strike a good balance between maximizing hassle-free
contributions and minimizing spam. This most recent round was Asheesh's
idea and it seems to be successful. Thus I'm documenting it here.

We installed the
`ConfirmEdit <http://www.mediawiki.org/wiki/Extension:ConfirmEdit>`__
extension for MediaWiki. That gives us an additional addurl permission
that MediaWiki doesn't have. I set this addurl permission to require a
captcha and then I wrote my EmailConfirmedNonCaptcha captcha plugin for
the ConfirmEdit extension.

The gist of the EmailConfirmedNonCaptcha plugin is that it always
rejects the change with a nice message if the user isn't in the
emailconfirmed group. That's it.

Now we have new user accounts created, but the accounts can't do
anything because they're not made by humans and they're not confirming
their email addresses. Thus this particular spam vector is dead in its
tracks without hassling potential contributors.

.. thumbnail:: /images/recent_changes_after.png

   After....

I posted a "project page" with the code for the extension at
http://pculture.org/wguaraldi/emailconfirmednoncaptcha/. But that
disappeared when I left PCF. I moved the project over to
https://github.com/willkg/ecnc on `GitHub <https://github.com/>`__.

**Updates:**

4/25/2011: Asheesh suggested I add some before and after screenshots.

4/25/2011 later: Correcting a totally silly thing I did by not
mentioning that I worked with Asheesh on this. It was totally his
idea. I just wrote it.

1/17/2012: I moved the project to GitHub and updated the urls in this
blog entry to reflect that.
