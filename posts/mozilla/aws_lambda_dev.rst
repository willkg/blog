.. title: AWS Lambda dev with Python
.. slug: aws_lambda_dev
.. date: 2018-04-12 12:00
.. tags: python, dev, socorro, story, mozilla

A story of a pigeon
===================

I work on `Socorro <https://github.com/mozilla-services/socorro>`_ which is the
crash ingestion pipeline for Mozilla's products.

The pipeline starts at the collector which handles incoming HTTP POST requests,
pulls out the payload, futzes with it a little, and then saves it to AWS S3.
Socorro then processes some of those crashes in the processor. The part that
connects the two is called Pigeon. It was intended as a short-term solution to
bridge the collector and the processor, but it's still around a year later and
the green grass grows all around all around and the green grass grows all
around.

Pigeon is an AWS Lambda function that triggers on S3 ObjectCreated:Put events,
looks at the filename, and then adds things to the processing queue depending on
the filename structure. We called it Pigeon for various hilarious reasons that
are too mundane to go into in this blog post.

It's pretty basic. It doesn't do much. It was a short term solution we thought
we'd throw away pretty quickly. I wrote some unit tests for the individual parts
of it and a "client" that invoked the function in a faux AWS Lambda like way.
That was good enough.


But then some problems
======================

Pigeon was written with Python 2 because at the time AWS Lambda didn't have a
Python 3 runtime. That changed--now there's one with Python 3.6.

In January, I decided to update Pigeon to work with Python 3.6. I tweaked the
code, tweaked the unit tests, and voila--it was done! Then we deployed it to
our -stage environment where it failed epically in technicolor glory (but no
sound!) and we had to back it out and return to the Python 2 version.

What happened? I'll tell you what happened--we had a shit testing environment.
Sure, we had tests, but they lacked several things:

1. At no point do we test against the build artifact for Pigeon. The build
   artifact for AWS Lambda jobs in Python is a .zip file that includes the code
   and all the libraries that it uses.

2. The tests "invoke" Pigeon with a "client", but it was pretty unlike the AWS
   Lambda Python 3.6 runtime.

3. Turns out I had completely misunderstood how I should be doing exception
   handling in AWS Lambda.

So our tests tested some things, but missed some important things and a big bug
didn't get caught before going to -stage.

It sucked. I felt chagrinned. I like to think I have a tolerance for failure
since I do it a lot, but this felt particularly faily and some basic safeguards
would have prevented it from happening.


Fleshing out AWS Lambda in Python project
=========================================

We were thinking of converting another part of the Socorro pipeline to AWS
Lambda, but I put that on hold until I had wrapped my head around how to build a
development environment that included scaffolding for testing AWS Lambda
functions in a real runtime.

Miles or Brian mentioned `aws-sam-local
<https://github.com/awslabs/aws-sam-local/>`_. I looked into that. It's written
in Go, they suggest installing it with npm, it does a bunch of things, and it
has some event generation code. But for the things I needed, it seemed like it
would just be a convenience cli for `docker-lambda
<https://github.com/lambci/docker-lambda>`_.

I had been aware of docker-lambda for a while, but hadn't looked at the project
recently. They added support for passing events via stdin. Their docs have
examples of invoking Lambda functions. That seemed like what I needed.

I took that and built the developer environment scaffolding that we've got in
Pigeon now. Further, I decided to use this same model for future AWS Lambda
function development.


How does it work?
=================

Pigeon is a Python project, so it uses Python libraries. I maintain those
requirements in a ``requirements.txt`` file.

I install the requirements into a ``./build`` directory:

.. code:: shell

   $ pip install --ignore-installed --no-cache-dir -r requirements.txt -t build/


I copy the Pigeon source into that directory, too:

.. code:: shell

   $ cp pigeon.py build/


That's all I need for the runtime to use.

The tests are in the ``tests/`` directory. I'm using `pytest
<https://pytest.org/>`_ and in the ``conftest.py`` file have this at the top:

.. code:: python

   import os
   import sys

   # Insert build/ directory in sys.path so we can import pigeon
   sys.path.insert(
       0,
       os.path.join(
           os.path.dirname(os.path.dirname(__file__)),
           'build'
       )
   )


I'm using Docker and docker-compose to aid development. I use a ``test``
container which is a ``python:3.6`` image with the test requirements installed
in it.

In this way, tests run against the ``./build`` directory.

Now I want to be able to invoke Pigeon in an AWS Lambda runtime so I can debug
issues and also write an integration test.

I set up a ``lambda-run`` container that uses the ``lambci/lambda:python3.6``
image. I mount ``./build`` as ``/var/task`` since that's where the AWS Lambda
runtime expects things to be.

I created a shell script for invoking Pigeon:

.. code:: shell

   #!/bin/bash

   docker-compose run \
       --rm \
       -v "$PWD/build":/var/task \
       --service-ports \
       -e DOCKER_LAMBDA_USE_STDIN=1 \
       lambda-run pigeon.handler $@


That's based on the docker-lambda invoke examples.

Let's walk through that:

1. It runs the ``lambda-run`` container with the services it depends on as
   defined in my ``docker-compose.yml`` file.

2. It mounts the ``./build`` directory as ``/var/task`` because that's where the
   runtime expectes the code it's running to be.

3. The ``DOCKER_LAMBDA_USE_STDIN=1`` environment variable causes it to look at
   stdin for the event. That's pretty convenient.

4. It runs invokes ``pigeon.handler`` which is the ``handler`` function in the
   ``pigeon`` Python module.

I have another script that generates fake AWS S3 ObjectCreated:Put events. I cat
the result of that into the invoke shell script. That runs everything nicely:

.. code:: shell

   $ ./bin/generate_event.py --key v2/raw_crash/000/20180313/00007bd0-2d1c-4865-af09-80bc00180313 > event.json
   $ cat event.json | ./bin/run_invoke.sh
   Starting socorropigeon_rabbitmq_1 ... done
   START RequestId: 921b4ecf-6e3f-4bc1-adf6-7d58e4d41f47 Version: $LATEST
   {"Timestamp": 1523588759480920064, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 4, "Pid": 1, "Fields": {"msg": "Please set PIGEON_AWS_REGION. Returning original unencrypted data."}}
   {"Timestamp": 1523588759481024512, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 4, "Pid": 1, "Fields": {"msg": "Please set PIGEON_AWS_REGION. Returning original unencrypted data."}}
   {"Timestamp": 1523588759481599232, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 6, "Pid": 1, "Fields": {"msg": "number of records: 1"}}
   {"Timestamp": 1523588759481796864, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 6, "Pid": 1, "Fields": {"msg": "looking at key: v2/raw_crash/000/20180313/00007bd0-2d1c-4865-af09-80bc00180313"}}
   {"Timestamp": 1523588759481933056, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 6, "Pid": 1, "Fields": {"msg": "crash id: 00007bd0-2d1c-4865-af09-80bc00180313 in dev_bucket"}}
   MONITORING|1523588759|1|count|socorro.pigeon.accept|#env:test
   {"Timestamp": 1523588759497482240, "Type": "pigeon", "Logger": "antenna", "Hostname": "300fca32d996", "EnvVersion": "2.0", "Severity": 6, "Pid": 1, "Fields": {"msg": "00007bd0-2d1c-4865-af09-80bc00180313: publishing to socorrodev.normal"}}
   END RequestId: 921b4ecf-6e3f-4bc1-adf6-7d58e4d41f47
   REPORT RequestId: 921b4ecf-6e3f-4bc1-adf6-7d58e4d41f47 Duration: 101 ms Billed Duration: 200 ms Memory Size: 1536 MB Max Memory Used: 28 MB
    
   null


Then I wrote an integration test that cleared RabbitMQ queue, ran the invoke
script with a bunch of different keys, and then checked what was in the
processor queue.

Now I've got:

* tests that test the individual bits of Pigeon
* a way to run Pigeon in the same environment as -stage and -prod
* an integration test that runs the whole setup

A thing I hadn't mentioned was that Pigeon's documentation is entirely in the
README. The docs cover setup and development well enough that I can hand this
off to normal people and future me. I like simple docs. Building scaffolding
such that docs are simple makes me happy.


Summary
=======

You can see the project at
`<https://github.com/mozilla-services/socorro-pigeon>`_.
