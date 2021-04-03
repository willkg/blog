.. title: My thoughts on Elasticsearch: Part 1: indexing
.. slug: elasticsearch_part1_index
.. date: 2013-05-10 13:49:00
.. tags: elasticsearch, work, dev, elasticutils, pyelasticsearch


Summary
=======

I just finished up an overhaul of `ElasticUtils
<http://elasticutils.rtfd.org>`_ and then an overhaul of the search
infrastructure for `support.mozilla.org
<https://support.mozilla.org>`_.  During that period of time, I
thought about extending the ElasticUtils documentation to include
things I discovered while working on these projects.  Then I decided
that this information is temporal---it's probably good now, but might
not be in a year.  Maintaining it in the ElasticUtils docs seemed like
more work than it was worth.

Thus I decided to write a series of blog posts.

This one covers indexing.  Later ones will cover mappings, searching
and other things.

It's also long, rambling and contains code.  The rest is after the
break.

.. TEASER_END


Code in this blog post
======================

The examples are in Python and use `pyelasticsearch
<http://pyelasticsearch.rtfd.org>`_.

If you want to follow along in your dev environment, set up a Python
virtual environment like this:

.. code::

   $ mkvirtualenv es
   $ pip install pyelasticsearch


Then you can activate that environment and fiddle with things.

Also, assume all this code starts with:

.. code:: python

   from pyelasticsearch.client import ElasticSearch

   es = ElasticSearch()


What are the basic blocks?
==========================

Let's talk basic building blocks first.


**Indexes**

    Let's say that an Elasticsearch index is equivalent to a MySQL
    database.  Multiple indexes can exist on a single Elasticsearch
    cluster.  Each index is a container for documents.


**Documents and document types**

    A document is bunch of key/value pairs.  Elasticsearch uses a
    JSON-based API, so let's think about documents as a JSON object.

    Each document has a type.  The type let's you easily distinguish
    one set of documents representing one thing from another set of
    documents representing another thing.

    Types are not containers.  All the document regardless of their
    type exist as documents in the index.


**Mappings**

    When you add a document to an index, Elasticsearch analyzes the
    field data thus making it available for search.

    You can let Elasticsearch infer how to analyze the field data or
    you can explicitly specify how Elasticsearch should analyze the
    fields by specifying a mapping.  Mappings map field names to
    analysis instructions for a given document type.


Quick recap:

* Elasticsearch has indexes which are containers holding documents
* Documents are a group of key/value pairs.
* Documents have a type.
* You can specify a mapping which gives Elasticsearch instructions on
  how to analyze fields in a document for a given document type.


Creating an index
=================

Creating an index with pyelasticsearch is pretty easy.  The basic form
is this:

.. code:: python

   es.create_index('blog-index')


**Thought 1: Good to define mappings when you define your index**

I think it's a good idea to define the mappings and set any
index-level settings when you create index.

If you've got code that adds documents to the index in `post_save`
hooks or something like that, it's a good idea to create the index and
define the mappings at the same time otherwise you run into the race
condition where you create the index, a document sneaks in causing
Elasticsearch to infer types, then you define a mapping that conflicts
with those types and things go awry.

Here's an example of creating an index and setting the mappings:

.. code:: python

   entry_mapping = {
       'entry-type': {
           'properties': {
               'id': {'type': 'integer'},
               'published': {'type': 'date'},
               'title': {'type': 'string'},
               'tags': {'type': 'string', 'analyzer': 'keyword'},
               'content': {'type': 'string'}
           }
       }

   es.create_index('blog-index', settings={'mappings': entry_mapping})


**Thought 2: You can't change your mappings**

You can't change the analysis information in your mappings after
you've got documents in your index.  This comes up semi-frequently.

There are a few options:

1. **Wipe and recreate**

   Create a new index with the updated mappings, then reindex all your
   documents into the new index.

   This is what we do for Input (`<https://input.mozilla.org/>`_)
   where search isn't the critical part of the site and where we
   adjust mappings rarely.

2. **Have read and write indexes and do a two-step deployment**

   This is what we do for SUMO (`<https://support.mozilla.org/>`_)
   where search **is** a critical part of the site and where we adjust
   mappings every month or two.  We push mapping changes in two steps.
   The first step includes all the changes to indexing, creates a new
   index for writes and reindexes everything into that.  The second
   step includes all the changes to search and viewing and changes the
   read index to look at the write index.  This is more complicated,
   but allows us to push mapping changes with no downtime.

3. **Use different field names**

   Instead of changing the analysis information for existing fields in
   the mapping, create new fields with the new analysis information.

   Use the `put mapping API
   <http://www.elasticsearch.org/guide/reference/api/admin-indices-put-mapping/>`_
   to push the new version of the mapping.  Elasticsearch will merge
   the original mapping with the new one and since your changes were
   additive, there aren't any conflicts and everything is super.

   Then change your indexing code so you're putting data in the new
   fields rather than the old ones and reindex all your documents.

   Then make sure your search code uses the new fields rather than the
   old one.


**Thought 3: Wait until cluster is yellow before indexing**

It takes a smidgeon of time for Elasticsearch to create the index and
for it to propagate to shards (or something like that).  It's good to
wait until things are fine before indexing.  Easiest way to do that is
use the `cluster health API
<http://www.elasticsearch.org/guide/reference/api/admin-cluster-health/>`_
like this:

.. code:: python

   es.health(wait_for_status='yellow')


That will block and wait for "yellow" which means that the primary
shard is allocated so you're good to go for indexing.

You definitely want to do this in your test code if you're creating
and tearing down indexes in rapid succession.

For some reason, this reminds me of a line in Ghostbusters: "Light is
green---trap is clean."


Indexing documents
==================

Indexing documents is probably pretty straight-forward.  It uses the
`index API
<http://www.elasticsearch.org/guide/reference/api/index_/>`_ The basic
code looks like this:

.. code:: python

   import datetime

   document = {
       'id': 1
       'title': 'Elasticsearch Part 1: Indexing',
       'tags': ['elasticsearch', 'work'],
       'published': datetime.datetime(2013, 5, 9, 17, 33),
       'content': 'Drivel drivel drivel.',
   }

   es.index('blog-index', 'entry-type', document, id=document['id'])


**Thought 1: Refreshing**

After you index a document, it won't be available for searching until
after the index is refreshed using the `refresh API
<http://www.elasticsearch.org/guide/reference/api/admin-indices-refresh/>`_.

Indexes are set to refresh at some periodic interval which by default
is 1 second.

You can explicitly refresh the index:

.. code:: python

   es.refresh('blog-index')


I only explicitly refresh the index during unit tests when I need to
search immediately.  Otherwise I let Elasticsearch refresh when it's
set to.

When I'm reindexing everything, I shut off the periodic refreshing and
then turn it back on after indexing is done.  You can do this with the
`update settings API
<http://www.elasticsearch.org/guide/reference/api/admin-indices-update-settings/>`_:

.. code:: python

   settings = es.get_settings('blog-index')
   settings = settings.get('blog-index', {})
   settings = settings.get('settings', {})

   refresh_interval = settings.get('index.refresh_interval', '1s')

   es.update_settings(
       'blog-index', {'index.refresh_interval': '-1'})

   # do your indexing here...

   es.update_settings(
       'blog-index', {'index.refresh_interval': refresh_interval})


**Thought 2: Bulk index when you can**

If you're indexing more than one document, you should use bulk
indexing using the `bulk API
<http://www.elasticsearch.org/guide/reference/api/bulk/>`_.  The basic
form for indexing is:

.. code:: python

   documents = [
       {
           'id': 1
           'title': 'Elasticsearch Part 1: Indexing',
           'tags': ['elasticsearch', 'work'],
           'published': datetime.datetime(2013, 5, 9, 17, 33),
           'content': 'Drivel drivel drivel.',
       },
       {
           'id': 1
           'title': 'Elasticsearch Part 1: Indexing',
           'tags': ['elasticsearch', 'work'],
           'published': datetime.datetime(2013, 5, 9, 17, 33),
           'content': 'Drivel drivel drivel.',
       },

       # ...
   ]

   es.bulk_index('blog-index', 'entry-type', documents, id_field='id')


It's pretty key that you get the ``id_field`` right.  If you don't,
then Elasticsearch will generate ids and you won't be able to use the
`get API <http://www.elasticsearch.org/guide/reference/api/get/>`_ to
pull documents out of your index.

The number of documents you index in one bulk_index call depends on the
size of your documents.  For SUMO, we do 80 at a time.  Our documents
range between 400 bytes and 300000 bytes.  Doing 80 at a time seems to
be an unscientifically measured sweet spot for our development
infrastructure.


**Half thought 3: Shards**

I've been told, but have never done myself, that you can use the
settings API to shut off replication to shards before you go reindex
everything which will make reindexing faster or something to that
effect.

We don't do this with SUMO or Input because our indexing is
bottlenecked on how fast we can get things out of the database.

This is worth looking into if your bottleneck is pushing things into
Elasticsearch.


**Thought 4: id**

That brings me to ids.  Elasticsearch generates ids, but they look
like character names from a Lovecraft novel.  If you don't want that,
then you should specify your own document id.

You can't have two documents with the same document type with the
same id.

In SUMO and Input, we use the id we get from the database.


**Thought 5: Updating your index**

After you index everything, it's likely the source data will continue
to change.  Thus you need to update the documents in the index over
time to match the source data.

With both Input and SUMO, we added ``post_save`` hooks to the Django
ORM models.  When those hooks kick off, they create celery tasks to
reindex that model instance.  In this way, the index stays pretty up
to date.

If you have a lot of churn in your database, then you might want to
queue up updates and then update everything in the queue every 15
minutes or something like that with bulk indexing.


Summary
=======

That about sums up my thoughts on indexing.  If you see something
wrong, email me.


Helpful urls
============

Elasticsearch and libs:

* Elasticsearch: http://www.elasticsearch.org/guide/
* pyelasticsearch: https://pyelasticsearch.readthedocs.org/
* ElasticUtils: https://elasticutils.readthedocs.org/

Elasticsearch API links:

* cluster health: http://www.elasticsearch.org/guide/reference/api/admin-cluster-health/
* index: http://www.elasticsearch.org/guide/reference/api/index\_/
* create index: http://www.elasticsearch.org/guide/reference/api/admin-indices-create-index/
* put mapping: http://www.elasticsearch.org/guide/reference/api/admin-indices-put-mapping/
* refresh: http://www.elasticsearch.org/guide/reference/api/admin-indices-refresh/
* get: http://www.elasticsearch.org/guide/reference/api/get/
* update settings: http://www.elasticsearch.org/guide/reference/api/admin-indices-update-settings/
* bulk index: http://www.elasticsearch.org/guide/reference/api/bulk/


Thanks!
=======

Thank you to James, Erik, Ricky, Rob, Hanno, Rehan, Jen, Mike, my
roommates and all the other people who helped me publish this wanton
piece of illegible drivel.


:May 11th, 2013: Fixed some minor issues and added note about how many to bulk index at a time.
