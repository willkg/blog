.. title: Tecken: The long windy journey to reproducing a problem remove_orphaned_files fixes
.. slug: tecken_worker_exit
.. date: 2023-11-30 10:00:17 UTC-05:00
.. tags: mozilla, work, tecken, dev, story

Summary
=======

This post talks about a stability problem we have with Tecken, some work we're
doing to make it better, and the steps to reproduce the problem in a local dev
environment.


.. TEASER_END


The backstory
=============

Tecken has an upload API which takes large payloads of symbols files, processes
them, and then uploads them to S3. The payload can be as big as 2 GB and can
contain many symbols files. The upload handler code uses the disk to extract
the files to and then process them. Processing the payload sometimes exceeds
the 5 minute timeout that we have for Gunicorn workers processing HTTP
requests. We theorized that when processing exceeds the 5 minute timeout, the
Gunicorn manager kills the Gunicorn worker orphaning the files on disk. If this
happens enough times, then the disk fills up and the instance throws
out-of-disk errors and then the Symbols service starts going sideways.

There are a handful of problems here.


**Gunicorn workers sometimes take too long to process an upload request.**

When a Gunicorn worker takes more than 5 minutes to process an upload request,
the Gunicorn manager kills it off.

We don't know in what scenarios this happens--we have no metrics or logging or
anything to tell us how often it happens or in what circumstances.

How often are Gunicorn workers killed because they exceeded the timeout?

What does the payload look like when a Gunicorn worker is killed? Are they big?
Do they have a lot of files? Do they have specific kinds of files?

More recently, I wonder whether it happens frequently on Tecken instances that
have exceeded the disk iops allotment and are being throttled--instances are
c5.large and thus are using EBS disk. Changing that is covered in
`OBS-68 <https://mozilla-hub.atlassian.net/browse/OBS-68>`__ [1]_.

.. [1] You can't see this unless you're a Mozilla employee.

We should look into providing more visibility here. Generally, we need more
visibility into the health of the upload API. This is covered in
`bug 1847235 <https://bugzilla.mozilla.org/show_bug.cgi?id=1847235>`__.


**Instances that are hitting "disk is full" errors never indicate they're
unhealthy in either the ``/__heartbeat__`` or ``/__lbheartbeat__`` endpoints so
they never get taken out of service.**

This is tricky.

First, there are multiple Gunicorn workers that come and go and there's no
centralized place to keep track of how many times a "disk is full" error is
kicked up for an instance.

Second, a "disk is full" error could be ephemeral and the Tecken instance could
recover. We don't want to mark the instance unhealthy the first time it
happens--we probably want to mark it unhealthy if it happens multiple times in
a short period of time.

This is an unsolved problem.


**Instances run out of disk.**

If multiple Gunicorn workers are terminated, an instance accumulates orphaned
files on disk and eventually we hit a point where the instance can't handle
uploads. There was nothing to reclaim that disk space.

We have mitigated this by adding a disk manager which runs
remove_orphaned_files periodically.

This has been working, but it kicks in too slowly. Here's an event in early
November where we see instances running out of disk and we see the
``remove_orphaned_files`` reclaim disk an hour later.

.. thumbnail:: /images/tecken_worker_exit_disk_full.png

   Grafana panel showing disk usage over two hours for multiple Tecken
   instances.

`Grafana dashboard <https://earthangel-b40313e5.influxcloud.net/d/a9-7FT0Zk/tecken-app-metrics?orgId=1&from=1699023820000&to=1699034331000>`__ [2]_

.. [2] You can't see this unless you're a Mozilla employee.

When the lines go up, disk is being used for processing files. When an upload
request is done being processed, the files are removed, so the line should go
back down again.

The problem scenario is when the line goes up and then stays there and doesn't
come back down again.

``remove_orphaned_files`` will kick in and delete files that have been on disk for
an hour--clearly they've been orphaned at this point. Then the lines will drop
precipitously back to normal levels.

In `bug 1863007 <https://bugzilla.mozilla.org/show_bug.cgi?id=1863007>`__, I
dropped the cutoff time from 60 minutes to 15 minutes. That will reduce the
time it takes to recoup disk and make it more likely instances won't run out of
disk without accidentally incorrectly removing files that are being processed.


**The disk manager isn't resilient to ephemeral service issues and silently
fails.**

We had an incident on September 9th, 2023 where I pushed a crummy change to
production that caused the db to be tied up.

The ``remove_orphaned_files`` command is a Django command. When it runs, it
would first do Django checks one of which was to check if it could connect to
the database.

In the case of September 9th, the bug caused the db to be tied up. Then this
happened:

1. ``remove_orphaned_files`` would go to do the Django checks and try to
   connect to the database
2. it would fail to connect to the database, so ``remove_orphaned_files`` would
   exit with a non-zero exit code
3. the script that runs ``remove_orphaned_files`` had ``set -e``, so it would
   exit because ``remove_orphaned_files`` exited with a non-zero exit code
4. Honcho would see the disk manager process exit, so it would shut down the
   web process
5. then Honcho would exit and the Docker container would stop
6. the Tecken instance would then restart the Docker container and we repeat
   all these steps again

We don't see anything in Sentry because no Sentry events are emitted, but we do
see the Docker container flapping in the logs.

So that's bad. We can make this less bad.

``remove_orphaned_files`` doesn't need the database, so we needed to call it
with ``--skip-checks`` so the Django checks aren't run. That allows it to run
even if the db (which it doesn't use) isn't available.

The script shouldn't exit in the case of an error running
``remove_orphaned_files`` which eventually leads to the Docker container
shutting down. I removed the ``set -e``.

Further, when ``remove_orphaned_files`` fails, we need some signal in Sentry
about it. I wrap the ``remove_orphaned_files`` invocation with a
``sentry-wrap`` script we have so if ``remove_orphaned_files`` terminates and
doesn't manage to send a Sentry event, we still get a Sentry event.

Improving the disk manager's resilience is covered in
`bug 1853962 <https://bugzilla.mozilla.org/show_bug.cgi?id=1853962>`__.

That's the backstory.


What happened this week?
========================

I'm trying to fix some of these stability issues with Tecken so there's less
risk it has problems at the end of December when we have reduced staff because
everyone is enjoying their holidays.

First, I dropped the cutoff in ``remove_orphaned_files`` from 60 minutes to 15
minutes so it'll reclaim disk more quickly. That's covered in
`PR 2839 <https://github.com/mozilla-services/tecken/pull/2839>`__.

I also fixed some of the issues with ``remove_orphaned_files`` and the script
that calls it so it's more resilient. That's covered in
`PR 2840 <https://github.com/mozilla-services/tecken/pull/2840>`__.

Bianca offered to review PR 2840 and as part of that review, wanted to
understand all the pieces involved and wanted to be able to trigger the problem
before and after to make sure that ``remove_orphaned_files`` is doing what it
needs to be doing. After a couple of long conversations on Slack and a couple of Zooms, we
uncovered a handful of other issues with ``sentry-wrap`` and
``remove_orphaned_files``. Further, we worked out a set of steps that allow us
to trigger the problem in a local dev environment.

Now we're at the point of this blog post--how do we reprodce the problem in a
local dev environment where the webapp orphans files on disk?

This is a manual process involving one symbols file, two changes, and three
terminals:


**Symbols file**

Download this file to your computer and put it in the Tecken repository root directory.

https://symbols.mozilla.org/libxul.so/709530256E7AF8B0FFF2B8F131FC170E0/libxul.so.sym


**Changes**

Add this to ``.env`` file to reduce the timeout to 60 seconds:

.. code:: shell

    GUNICORN_TIMEOUT=60


Add a sleep line to ``tecken/uploads/utils.py`` which forces upload handling to
take too long, but in a place which doesn't get interrupted when the Gunicorn
manager first sends SIGABRT.

.. code:: diff

    diff --git a/tecken/upload/utils.py b/tecken/upload/utils.py
    index aaf51dd3..79c48231 100644
    --- a/tecken/upload/utils.py
    +++ b/tecken/upload/utils.py
    @@ -241,6 +241,8 @@ def upload_file_upload(
     	    client_lookup or client, bucket_name, key_name
 	    )
     
    +	import time; time.sleep(70)
    +
 	    size = os.stat(file_path).st_size
     
 	    if not should_compressed_key(key_name):


**Terminal 1: the webapp**

In this terminal, set up the local dev environment and run the webapp:

.. code:: shell

    #!/bin/bash

    FAKEUSERNAME="wkahngreene"
    FAKEPASSWORD="foo"
    FAKEEMAIL="wkahngreene@mozilla.com"
    FAKETOKEN="c7c1f8cab79545b6a06bc4122f0eb3cb"

    # Build Tecken
    make build

    # Start services
    docker compose up -d --remove-orphans db redis-cache statsd localstack oidcprovider fakesentry

    # Run setup
    make setup

    # Set up user
    docker compose run --rm web bash python manage.py superuser "${FAKEEMAIL}"
    docker compose exec oidcprovider /code/manage.py createuser "${FAKEUSERNAME}" "${FAKEPASSWORD}" "${FAKEEMAIL}"
    docker compose run --rm web bash python manage.py createtoken "${FAKEEMAIL}" "${FAKETOKEN}"


Then run the webapp:

.. code:: shell

    make run


**Terminal 2: shell to see /tmp/uploads contents**

We need a shell inside the Docker container running the webapp so we can see
the contents of ``/tmp/uploads`` which is where the webapp puts files it's
working on when handling the upload request.

.. code:: shell

    docker compose exec web /bin/bash


**Terminal 3: shell to upload a file**

We need a shell we can use to upload a symbol file to the webapp triggering
everything.

.. code:: shell

    make shell

Then in that shell, we do:

.. code:: shell

    ./bin/upload-sym.py --auth-token=c7c1f8cab79545b6a06bc4122f0eb3cb --base-url=http://web:8000 libxul.so.sym


**So what happens?**

In Terminal 1 (the webapp), we see the upload request and then after a minute,
we see the Gunicorn manager send a SIGABRT to the worker, but the worker keeps
on trucking, so then the Gunicorn manager sends a SIGKILL to the worker
terminating the process.

::

    tecken-web-1       	| INFO 2023-11-30 13:47:57,890 - webapp - markus METRICS|2023-11-30 13:47:57|timing|tecken.upload_dump_and_extract|3.3822989935288206|
    tecken-web-1       	| INFO 2023-11-30 13:47:58,034 - webapp - markus METRICS|2023-11-30 13:47:58|timing|tecken.upload_file_exists|6.215944988070987|
    tecken-web-1       	| DEBUG 2023-11-30 13:47:58,034 - webapp - tecken key_existing cache miss on publicbucket:v1/libssl3.so/B68D6DF6915DDCBD20F569A412D6886E0/libssl3.so
    tecken-web-1       	| [2023-11-30 13:48:58 +0000] [16] [CRITICAL] WORKER TIMEOUT (pid:18)
    tecken-web-1       	| INFO 2023-11-30 13:48:58,861 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:48:58,861 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| [2023-11-30 13:48:59 +0000] [16] [ERROR] Worker (pid:18) was sent SIGKILL! Perhaps out of memory?
    tecken-web-1       	| [2023-11-30 13:48:59 +0000] [46] [INFO] Booting worker with pid: 46


After that's happened, we use Terminal 2 (shell in the webapp container) to
look at the contents of ``/tmp/uploads`` and verify that files are now orphaned:

.. code:: shell

    app@e54fc487d951:/tmp$ find -type f /tmp
    /tmp/uploads/tmpi3625chl/libxul.so/709530256E7AF8B0FFF2B8F131FC170E0/libxul.so.sym
    /tmp/requirements.txt


Then we wait and watch the output of Terminal 1 for ``remove_orphaned_files`` to
note the cutoff has been exceeded and delete the file.

::

    tecken-web-1       	| INFO 2023-11-30 13:49:59,963 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:49:59,963 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:51:01,093 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:51:01,093 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:52:02,190 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:52:02,191 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:53:03,302 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:53:03,303 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:54:04,436 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:54:04,436 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:55:05,522 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:55:05,523 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:56:06,614 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:56:06,614 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:57:07,703 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:57:07,703 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:58:08,775 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:58:08,775 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 13:59:09,866 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 13:59:09,866 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 14:00:10,981 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 14:00:10,982 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 14:01:12,054 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 14:01:12,054 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 14:02:13,125 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 14:02:13,126 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 14:03:14,212 - disk_manager - tecken.remove_orphaned_files expires: 15 (minutes)
    tecken-web-1       	| INFO 2023-11-30 14:03:14,212 - disk_manager - tecken.remove_orphaned_files watchdir: '/tmp/uploads'
    tecken-web-1       	| INFO 2023-11-30 14:03:14,213 - disk_manager - tecken.remove_orphaned_files deleted file: /tmp/uploads/tmpi3625chl/libssl3.so/B68D6DF6915DDCBD20F569A412D6886E0/libssl3.so, 728678b
    tecken-web-1       	| INFO 2023-11-30 14:03:14,213 - disk_manager - markus METRICS|2023-11-30 14:03:14|incr|tecken.remove_orphaned_files.delete_file|1|


We use Terminal 2 to check the contents of the directory and the file is now gone:

.. code:: shell

    app@e54fc487d951:/tmp$ find -type f /tmp
    /tmp/requirements.txt


At this point, we've simulated the problem we're having in production where the
Gunicorn worker is terminated leaving behind files on the disk and the
``remove_orpahned_files`` command has cleaned them up.
