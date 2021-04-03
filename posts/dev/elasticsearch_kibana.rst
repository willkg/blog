.. title: Fiddling with Kibana
.. slug: elasticsearch_kibana
.. date: 2014-05-14 12:00
.. tags: elasticsearch, work, dev, mozilla


I just kicked off a script that's going to take around 4 hours to
complete mostly because the API it's running against doesn't want me
doing more than 60 requests/minute. Given I've got like 13k requests
to do, that takes a while.

I'm (ab)using Elasticsearch to store the data from my script so that I
can analyze it more easily--terms facet is pretty handy here.

Given that I've got some free time now, I spent 5 minutes setting up
`Kibana <http://www.elasticsearch.org/overview/kibana/>`_.

Steps:

1. download the tarball
2. untar it into a directory
3. edit ``kibana-3.0.1/config.js`` to point to my local Elasticsearch
   cluster (the defaults were fine, so I could have skipped this step)
4. ``cd kibana-3.0.1/`` and run ``python -m SimpleHTTPServer 5000``
   (I'm using a Python-y thing here, but you can use any web-server)
5. point my browser to ``http://localhost:5000``

Now I'm using Kibana.

Now that I've got it working, first thing I do is click on the cog
in the upper right hand corner, click on the Index tab and change
the index to the one I wanted to look at. Now I'm looking at the data
my script is producing.

The Kibana site says Kibana excels at timestamped data, but I think
it's helpful for what I'm looking at now despite it not being
timestamped. I get immediate terms facets on the fields for the doc
type I'm looking at. I can run queries, pick specific columns,
reorder, do graphs, save my dashboard to look at later, etc.

If you're doing Elasticsearch stuff, it's worth looking at if only to
give you another tool to look at data with.
