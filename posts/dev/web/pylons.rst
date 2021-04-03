.. title: Wedding site: using Pylons
.. slug: pylons
.. date: 2006-04-14 14:21:49
.. tags: dev, python, web


I'm building a wedding site that contains mostly static material
but has some material that's reminsicent of CMS and some material
that's database-driven, too.

I surveyed the scene of Python web-frameworks and settled on `Pylons
<http://pylonshq.com/>`_ for various reasons but mostly because:

* I liked their website.  It was easy to figure out what it does, how
  it's architected, and I can find what I'm looking for.
* It's built on Paste.  Paste is great infrastructure.
* It supports WSGI.  Makes it easier to interoperate with other
  applications.
* The project is healthy.

I've spent 40 minutes or so fiddling with the site so far with only a
few minor issues which required me to go poking through documentation.  
One of the issues is that I have a series of templates in my templates/ 
dir and I uncommented out the commented out code in the 
``template.py`` controller so it's like this:

.. code-block:: python

   from weddingwww.lib.base import *

   class TemplateController(BaseController):
       def view(self, url):
           from pkg_resources import resource_exists
           if resource_exists('weddingwww', url+'.myt'):
               m.subexec(url+'.myt')
           else:
               m.abort(404, "File not found '%s'" % url)


That doesn't seem to work as I'd expect.  For example, if I go to
``http://localhost:5000/meeting``, the ``url`` parameter ends up as ``meeting``
but the resources_exist returns a false even though there's a ``meeting.myt``
file in my templates directory.

After fiddling with this and trying to figure out where pkg_resources
is defined, I just commented the code out and changed it to this:

.. code-block:: python

   from weddingwww.lib.base import *

   class TemplateController(BaseController):
       def view(self, url):
           m.subexec(url+'.myt')


which obviously does the wrong thing if the file doesn't exist.
