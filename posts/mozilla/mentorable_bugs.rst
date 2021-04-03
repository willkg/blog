.. title: Using the bug_mentor field with the Bugzilla REST API to get mentored bugs
.. slug: mentorable_bugs
.. date: 2014-06-19 20:20
.. tags: mozilla, work, bugzilla, dev


**Updated June 23rd, 2014:**
    There's a better way to query the data. :doc:`See the update blog post
    <mentorable_bugs2>`.

`Bugzilla <https://bugzilla.mozilla.org>`_ grew a mentor field recently.
This is really fantastic as it solves some interesting problems and makes
it easier to track various aspects of mentoring which have been previously
difficult to track. Yay to everyone involved in making that happen!

Migrating from the old way (sticking ``[mentor=xxx]`` in the
``whiteboard`` field) to the new way caused a problem that I spent a
while working on today. I heard reports of other people having the
same problem, hence this blog post.

There are a bunch of Bugzilla-symbiotic systems which would show a
list of mentored bugs by checking to see if the string ``mentor=``
was in the whiteboard field. That no longer works. Instead we have to
check to see if the ``bug_mentor`` field is empty. However, this is
difficult to express with the old Bugzilla REST API (BzAPI).

The ``bug_mentor`` field is unique in that it holds email addresses
which have the ``@`` in them. So we can (ab)use this property by
seeing if the ``bug_mentor`` field contains the ``@`` character.

I did this with the `GetInvolved/input.mozilla.org
<https://wiki.mozilla.org/Webdev/GetInvolved/input.mozilla.org>`_ page.
`Here is the diff <https://wiki.mozilla.org/index.php?title=Webdev/GetInvolved/input.mozilla.org&diff=990591&oldid=644482>`_
in case that's helpful.

Here's some Python that shows this with the old BzAPI and the new BMO
API which pulls mentored bugs for `Input
<https://input.mozilla.org>`_:

.. code:: python

    import requests

    # Using the old BzAPI: https://wiki.mozilla.org/Bugzilla:REST_API
    r = requests.get(
        'https://api-dev.bugzilla.mozilla.org/latest' +
        '/bug?product=Input&bug_mentor_type=contains&bug_mentor=@'
    )
    data = r.json()
    print len(data['bugs'])  # Prints 9


    # Using the new BMO API. https://wiki.mozilla.org/BMO/REST
    r = requests.get(
        'https://bugzilla.mozilla.org/rest' +
        '/bug?product=Input&bug_mentor_type=substring&bug_mentor=@'
    )
    data = r.json()
    print len(data['bugs'])  # Prints 9
