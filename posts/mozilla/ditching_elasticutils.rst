.. title: Ditching ElasticUtils on Input for elasticsearch-dsl-py
.. slug: ditching_elasticutils
.. date: 2015-07-01 14:20
.. tags: mozilla, work, elasticutils, dev, python, story


What was it?
============

`ElasticUtils <https://elasticutils.readthedocs.org/>`_ was a Python
library for building and executing Elasticsearch searches. I picked up
maintenance after the original authors left Mozilla. I maintained it and
released multiple versions and eventually ended the project in January 2015.

But why end it? There are a bunch of reasons.

It started at PyCon 2014, when I had a long talk with Rob, Jannis, and
Erik about ElasticUtils and the new library that Honza from Elastic was working
on. Honza's library became
`elasticsearch-dsl-py <http://elasticsearch-dsl.readthedocs.org/>`_.

At the time, I knew that ElasticUtils had multiple architectural
decisions that made maintenance difficult. ElasticUtils was architected and
built for a pre-1.0 Elasticsearch, and it would have been a monumental effort
to rework it to account for API changes in Elasticsearch 1.0. Further, the code
wasn't structured particularly well. We were likely looking at a library
rewrite.

Honza's library had a lot of promise and did the sorts of things that
ElasticUtils should have done and did them better--even in an early stage
of development.

By the end of PyCon 2014, I was pretty sure elasticsearch-dsl-py was
the future. The only question was whether to gut ElasticUtils and make it a
small shim on top of elasticsearch-dsl-py or to end the library altogether.

In January 2015, I decided it was better to deprecate ElasticUtils because
there wasn't a compelling reason to keep it around.

Now to migrate to elasticsearch-dsl-py.

.. TEASER_END


ElasticUtils and Input
======================

Even after ending ElasticUtils, Input continued to use it for months because
our Elasticsearch cluster was stuck at 0.90.10. ElasticUtils supported
Elasticsearch 0.90.10, but elasticsearch-dsl-py did not. We finally got managed
to upgrade Input to Elasticsearch 1.2.4 (which is still not supported, but at
least it's beyond the 1.0 hump)

This week at the Mozilla Whistler all-hands week, I spent some quality time
with the Elasticsearch code in Input and rewrote it to use
elasticsearch-dsl-py.

Figuring other people might have to do this, I thought it'd be worth
writing up a blog post with my thoughts.


Which version of elasticsearch-dsl-py?
======================================

At the time of this writing, the latest released version is
elasticsearch-dsl-py 0.4.

I hit a problem early on: ``DocType`` objects have no convenient way to convert
to a Python dict. In elasticsearch-dsl-py master tip, there's a ``.to_dict()``
method on ``DocType`` which does what I need.

Thus, I went with master tip figuring I'll pick up the next release when it
gets released.


ElasticUtils MappingType to elasticsearch-dsl-py DocType
========================================================

In ElasticUtils, we had ``MappingType`` and ``Indexable``, and you
could build classes that declaratively state the shape of the mapping
for your doctype. These classes had some functions to make it easy to
index, delete, and search those mapping types. Unfortunately, there was a fair
amount of scaffolding required to use these. Plus, the way they were structured
didn't really save you much time to use them.

In elasticsearch-dsl-py, the ``DocType`` class does a lot more. Declaring
the mapping of your document is a lot cleaner, and it's a lot easier
to do things with DocTypes.

ElasticUtils blog mapping type:

.. code:: python

   class BlogEntryMappingType(MappingType, Indexable):
       @classmethod
       def get_index(cls):
           return 'blog-index'

       @classmethod
       def get_mapping_type_name(cls):
           return 'blog-entry'

       @classmethod
       def get_model(cls):
           return BlogEntry

       @classmethod
       def get_es(cls):
           return get_es(urls=['http://localhost:9200'])

       @classmethod
       def get_mapping(cls):
           return {
               'properties': {
                   'id': {'type': 'integer'},
                   'title': {'type': 'string'},
                   'tags': {'type': 'string'},
                   'created': {'type': 'date'}
               }
           }

       @classmethod
       def extract_document(cls, obj_id, obj=None):
           if obj == None:
               obj = cls.get_model().get(id=obj_id)

           doc = {}
           doc['id'] = obj.id
           doc['title'] = obj.title
           doc['tags'] = obj.tags
           doc['created'] = obj.created
           return doc

       @classmethod
       def get_indexable(cls):
           return cls.get_model().get_objects()


In elasticsearch-dsl-py:

.. code::  python

   class BlogDocType(DocType):
       id = Integer()
       title = String(analyzer='snowball')
       tags = String(analyzer='keyword')
       created = Date()

       class Meta:
           name = 'blog-entry'
           index = 'blog-index'

       @classmethod
       def get_indexable(cls):
           return cls.get_model().get_objects()

       @classmethod
       def from_obj(cls, obj):
           return cls(
               id=obj.id,
               title=obj.title,
               tags=obj.tags,
               created=obj.created
           )


The latter is a lot less code and a lot easier to maintain. Converting
from ElasticUtils to elasticsearch-dsl-py was pretty straightforward for
doctypes.

One issue I had is that the documentation for elasticsearch-dsl-py isn't clear
on the types or options. In order to understand how to set up a ``DocType``
subclass, I ended up reading through the code. As elasticsearch-dsl-py
continues to mature, I'm sure this will improve.


ElasticUtils S to elasticsearch-dsl-py Search
=============================================

In ElasticUtils, you create an ``S`` and then use that ``S`` to
incrementally define a search using the ``.filter()`` and ``.query()``
methods. The ``.filter()`` and ``.query()`` methods could define a bunch
of filter/query parts all in one method call.

For example:

.. code:: python

   S().filter(title__match='elasticsearch', created__gte=datetime(2015, 6, 20))

elasticsearch-dsl-py has a ``Search`` which works essentially the same
way, but the method signatures are different. For example, ``.filter()``
and ``.query()`` calls only define a single filter/query.

For example:

.. code:: python

   (Search().filter('match', title='elasticsearch')
            .filter('range', created={'gte': datetime(2015, 6, 20)}))

That looks more complicated, but it's better API-design. ElasticUtils was
really limited in that you could only use the default filters/queries and
couldn't pass in arguments. The elasticsearch-dsl-py version lets you pass in
arguments.

Let's create a search against some blog data and do a filter and a query on it.

ElasticUtils:

.. code:: python

   # Create an S that we'll search blog docs with. It'll use an
   # Elasticsearch that connects to "localhost".
   search = S(BlogMappingType).es(urls=['localhost'])

   # Look at blog entries created on or after 6/20/2015.
   search = search.filter(created__gte=datetime(2015, 6, 20))

   # Look at blog entries that have titles that match elasticsearch
   search = search.query(title__match='elasticsearch')

   # Only show the first 5.
   search = search[:5]

   # Print them out.
   for doc in search:
       print doc.title, doc.created


elasticsearch-dsl-py:

.. code:: python

   # Create an S that we'll search blog docs with. It'll use an
   # Elasticsearch that connects to "localhost".
   search = Search(BlogDocType).using(Elasticsearch(urls=['localhost']))

   # Look at blog entries created on or after 6/20/2015.
   search = search.filter('range', created={'gte': datetime(2015, 6, 20)})

   # Look at blog entries that have titles that match elasticsearch
   search = search.query('match', title='elasticsearch')

   # Only show the first 5.
   search = search[:5]

   # Print them out.
   for doc in search.execute():
       print doc.title, doc.created


Generally, this kind of code converts pretty easily.


Facets to Aggregations
======================

ElasticUtils was of the pre-1.0 world and thus supported facets but
not aggregations. When converting Input from ElasticUtils to
elasticsearch-dsl-py, I spent most of my time on this part, because I'd never
used Elasticsearch aggregations before, so I had to understand how they worked
first.

I'm going to ditch the blog entry example I was using and instead just
show the code before and after for the two things I had to convert in
Input.

First, we have faceted navigation on the front page dashboard. On the
left side, you'd see a bunch of categories, and for each category,
you'd see all the values in that category and how many pieces of input
had that value.

In ElasticUtils, that code looked like this:

.. code:: python

   facets = search.facets(['happy', 'product', 'locale', 'version'],
                          filtered=bool(search._process_filters(f.filters)))
   for category, buckets in facet.facet_counts().items():
       for bucket in buckets:
           key = bucket['term']
           count = bucket['count']
           ...

In elasticsearch-dsl-py, that code looks like this:

.. code:: python

   # Note: .aggs modifies the search *in-place*.
   for key in ['happy', 'product', 'locale', 'version']:
       search.aggs.bucket(key, 'terms', field=name)

   results = search.execute()

   for category in ['happy', 'product', 'locale', 'version']:
       buckets = getattr(results, aggregations, category)['buckets']
       for bucket in buckets:
           key = bucket['key']
           count = bucket['doc_count']
           ...

I like that I don't have to do that ``filtered=...`` thing anymore.

The other case where we used facets was for date histogram data.
That's a little more complex because with ElasticUtils, we did two
``date_histogram`` facets, and in elasticsearch-dsl-py we use aggregations.

In ElasticUtils:

.. code:: python

   # Do a facet for happy and one for sad.
   happy_f = f & F(happy=True)
   sad_f = f & F(happy=False)
   histograms = search.facet_raw(
       happy={
           'date_histogram': {'interval': 'day', 'field': 'created'},
           'facet_filter': search._process_filters(happy_f.filters)
       },
       sad={
           'date_histogram': {'interval': 'day', 'field': 'created'},
           'facet_filter': search._process_filters(sad_f.filters)
       }
   ).facet_counts()

   # Reshape the data so it's a dict of time in ms -> count.
   happy_data = dict((p['time'], p['count']) for p in histograms['happy'])
   sad_data = dict((p['time'], p['count']) for p in histograms['sad'])


In elasticsearch-dsl-py:

.. code:: python

   # Top-level, do a date_histogram bucket for number of Input
   # feedback per day.
   search.aggs.bucket('histogram', 'date_histogram', field='created', interval='day')

   # Under that, get counts by sentiment type (e.g. happy and sad).
   search.aggs['histogram'].bucket('per_sentiment', 'terms', field='happy')

   results = search.execute()

   # We need to draw two lines, so we build two dicts of time-in-ms -> count.
   happy_data = {}
   sad_data = {}
   for bucket in results.aggregations['histogram']['buckets']:
       t = bucket['key']
       counts_dict = dict(
           (item['key'], item['doc_count'])
           for item in bucket['per_sentiment']['buckets']
       )

       happy_data[t] = counts_dict.get('T', 0)
       sad_data[t] = counts_dict.get('F', 0)

   ...


The aggregations code here is more complicated because we have to transform the
shape of the results into a different shape which the charting code in the
frontend expects. Otherwise, aggregations are easier to work with, plus it's
more powerful--something this example doesn't show.


Summary
=======

I'm still tweaking the changes and haven't posted a PR yet. The preliminary
changes cover 17 files with 559 insertions and 508 deletions.

I'm not seeing any differences in the time it takes to run the tests. Maybe
that means there isn't much of a performance change.

For the most part, it seems like converting the code is fairly straightforward.

There was some other code I had to change that I didn't talk about above. While
migrating from ElasticUtils to elasticsearch-dsl-py, I refactored some other
related things to fit together better.

I hope this blog post was helpful. If you have questions or there are issues,
let me know by sending me an email.
