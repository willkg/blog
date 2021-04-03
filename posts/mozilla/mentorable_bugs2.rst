.. title: (updated) Using the bug_mentor field with the Bugzilla REST API to get mentored bugs
.. slug: mentorable_bugs2
.. date: 2014-06-23 10:20
.. tags: mozilla, work, bugzilla


In my :doc:`previous post <mentorable_bugs>`, I
mentioned how Bugzilla grew a mentor field and had some code on how to
query Bugzilla using the old and new APIs for the list of mentored
bugs. This updates that information.

Gerv and Byron pointed out there's a ``isnotempty`` operator that's
better to use than the way I cobbled together to query for bugs that
have data in the ``bug_mentor`` field.

Thus, the code should look like this:

.. code:: python

    import requests

    # Using the old BzAPI: https://wiki.mozilla.org/Bugzilla:REST_API
    r = requests.get(
        'https://api-dev.bugzilla.mozilla.org/latest' +
        '/bug?product=Input&f1=bug_mentor&o1=isnotempty'
    )
    data = r.json()
    print len(data['bugs'])  # Prints 9


    # Using the new BMO API. https://wiki.mozilla.org/BMO/REST
    r = requests.get(
        'https://bugzilla.mozilla.org/rest' +
        '/bug?product=Input&f1=bug_mentor&o1=isnotempty'
    )
    data = r.json()
    print len(data['bugs'])  # Prints 9
