.. title: Using Localstack for a fake AWS S3 for local development
.. slug: using_localstack_for_s3
.. date: 2017-04-28 14:00
.. tags: python, dev, s3, aws, antenna

Summary
=======

Over the last year, I rewrote the `Socorro
<https://github.com/mozilla/socorro>`_ collector which is the edge of the
Mozilla crash ingestion pipeline. `Antenna
<https://github.com/mozilla/antenna>`_ (the new collector) receives crashes from
Breakpad clients as HTTP POSTs, converts the POST payload into JSON, and then
saves a bunch of stuff to AWS S3. One of the problems with this is that it's a
pain in the ass to do development on my laptop without being connected to the
Internet and using AWS S3.

This post covers the various things I did to have a locally running fake AWS S3
service.

.. TEASER_END


First, there was fakes3
=======================

Antenna is developed in a `Docker <https://docker.com>`_ environment, so I
wanted to treat "fake AWS S3" as a service which ran in a container separate
from Antenna.

The first system I looked at was `fakes3 <https://github.com/jubos/fake-s3>`_.
That ran in a container and it persisted data to the file system, so I could
mount that as a volume and in that way review what was actually getting saved
by Antenna.

I used that for a while since it met my needs, but then the authors switched the
project to a license that wasn't open source at which point I didn't want to use
it anymore.


Then, there was moto
====================

I skulked around for other solutions and ended up switching to `moto
<https://github.com/spulec/moto>`_. Moto was originally a mocking library, but
recently added a moto-server wrapper which let you run it as a service.

I didn't like any of the existing Docker images for Moto, so I rolled my own
with this ``Dockerfile.motos3`` file:

.. code::

  FROM python:3.5.3

  MAINTAINER Will Kahn-Greene <willkg@mozilla.com>

  # FIXME(willkg): Use a commit on master because 0.4.31 has bugs on buckets. Once a new
  # release has happened, we can switch to that.
  ENV MOTO_VERSION df84675ae67e717449f01fafe3a022eb14984e26

  RUN cd /tmp && \
      wget https://github.com/spulec/moto/archive/$MOTO_VERSION.tar.gz -O moto-$MOTO_VERSION.tar.gz && \
      tar -xzvf moto-$MOTO_VERSION.tar.gz && \
      cd moto-$MOTO_VERSION/ && \
      pip install .[server]

  # Port that moto listens on
  EXPOSE 5000

  # This spits out --help which isn't helpful, but you can specify what to do
  # by setting the command.
  ENTRYPOINT ["moto_server"]
  CMD ["--help"]


At the time of this writing, the latest release of moto is 4.31 which had a bug
which prevented me from creating buckets, so I used a commit on the master
branch after the 4.31 release.

(Also, note that I don't have a clue about best practices for Dockerfiles.)

Then I added this to my ``docker-compose.yml`` file:

.. code:: yaml

  services:
    # ...
    moto-s3:
      build:
        context: .
        dockerfile: Dockerfile.motos3
      command: s3 -H 0.0.0.0 -p5000
      ports:
        - "5000:5000"

This runs the ``moto-server`` Python program telling it to run the ``s3``
service and bind to all the IP addresses and listen at port 5000. It exposes
port 5000 so that other Docker containers can access it.

I used that for a bit.


Then, there was localstack
==========================

However, I didn't really want to maintain my own image and I'm about to start
working on another project that will probably use other AWS services. I had
glanced at `Localstack <https://github.com/atlassian/localstack>`_ a while back,
but it seemed too new at the time. I decided to look at it again.

I dropped my ``Dockerfile.motos3`` file and changed my ``docker-compose.yml``
file to this:

.. code:: yaml

   # https://hub.docker.com/r/atlassianlabs/localstack/
   # localstack running a fake S3
   localstack-s3:
     image: atlassianlabs/localstack:0.4.0
     environment:
       - SERVICES=s3:5000
       - DEFAULT_REGION=us-east-1
       - HOSTNAME=localstack-s3
     ports:
       - "5000:5000"


Under the hood, Localstack is using moto for S3, so it's essentially the same as
using moto. However, they maintain Docker images and the 0.4.0 image has a
patched version of moto that doesn't have the problem I had with creating
buckets.

There are a couple of things to know:

1. **It completely ignores AWS credentials.**

   So you don't have to set up credentials for S3 and whatever you use is
   happily ignored. For example, this would work fine:

   .. code:: shell

      AWS_ACCESS_KEY_ID=foo
      AWS_SECRET_ACCESS_KEY=foo


   I didn't particularly care about this. We verify credentials and access in
   system tests after deploys.

   That's covered in `<https://github.com/atlassian/localstack/issues/62>`_.

2. **It doesn't persist data between container restarts.**

   Localstack 0.4.0 uses moto-server's S3 implementation that's version 0.4.31
   with some additional patches. It stores everything entirely in memory and
   doesn't write anything to disk. If you restart the Docker container, you lose
   all the data.

   This was fine with me. I could use the aws-cli to look around the bucket and
   verify its contents.

   I wrote a shell script for that called ``laws.sh``:

   .. code:: shell

      #!/bin/bash

      export AWS_ACCESS_KEY_ID=foo
      export AWS_SECRET_ACCESS_KEY=foo

      aws --endpoint-url=http://localhost:5000 --region=us-east-1 s3 $@


   Used:

   .. code:: shell

      $ laws.sh ls s3:/antennabucket/


Hope that's helpful!
