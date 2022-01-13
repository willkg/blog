.. title: Everett v3.0.0 released!
.. slug: everett_3_0_0
.. date: 2022-01-13 13:30:00 UTC-05:00
.. tags: python, dev, everett
.. category: 
.. link: 
.. description: 
.. type: text

What is it?
===========

`Everett <https://everett.readthedocs.io/>`_ is a configuration library for Python
apps.

Goals of Everett:

1. flexible configuration from multiple configured environments
2. easy testing with configuration
3. easy automated documentation of configuration for users

From that, Everett has the following features:

* is flexible for your configuration environment needs and supports process
  environment, env files, dicts, INI files, YAML files, and writing your own
  configuration environments
* facilitates helpful error messages for users trying to configure your
  software
* has a Sphinx extension for documenting configuration including
  autocomponentconfig and automoduleconfig directives for automatically
  generating configuration documentation
* facilitates testing of configuration values
* supports parsing values of a variety of types like bool, int, lists of
  things, classes, and others and lets you write your own parsers
* supports key namespaces
* supports component architectures
* works with whatever you’re writing–command line tools, web sites, system daemons, etc


v3.0.0 released!
================

This is a major release that sports three things:

* **Adjustments in Python support.**

  Everett 3.0.0 drops support for Python 3.6 and picks up support for Python
  3.10.

* **Reworked namespaces so they work better with Everett components.**

  Previously, you couldn't apply a namespace after binding the configuration to
  a component. Now you can.

  This handles situations like this component:

  .. code:: python

      class MyComponent:
          class Config:
              http_host = Option(default="localhost")
              http_port = Option(default="8000", parser=int)

              db_host = Option(default="localhost")
              db_port = Option(default="5432", parser=int)

      config = ConfigManager.basic_config()

      # Bind the configuration to a specific component so you can only use
      # options defined in that component
      component_config = config.with_options(MyComponent)

      # Apply a namespace which acts as a prefix for options defined in
      # the component
      http_config = component_config.with_namespace("http")

      db_config = component_config.with_namespace("db")

* **Overhauled Sphinx extension.**

  This is the new thing that I'm most excited about. This fixes a lot of my
  problems with documenting configuration.

  Everett now lets you:

  * document options and components:
    
    Example option:

    .. code:: rst

        .. everett:option:: SOME_OPTION
           :parser: int
           :default: "5"
        
           Here's some option.

    Example component:

    .. code:: rst

        .. everett:component:: SOME_COMPONENT

           .. rubric:: Options

           .. everett:option:: SOME_OPTION
              :parser: int
              :default: "5"
           
              Here's some option.

  * autodocument all the options defined in a Python class

    Example ``autocomponentconfig``:

    .. code:: rst

        .. autocomponentconfig:: myproject.module.MyComponent
           :show-table:
           :case: upper

  * autodocument all the options defined in a Python module

    Example ``automoduleconfig``:

    .. code:: rst

        .. automoduleconfig:: mydjangoproject.settings._config
           :hide-name: 
           :show-table:
           :case: upper

  This works much better with configuration in Django settings modules. This
  works with component architectures. This works with centrally defining
  configuration with a configuration class.

  Further, all options and components are added to the index, have unique
  links, and are easier to link to in your documentation.

  I updated the Antenna (Mozilla crash ingestion collector) docs:

  https://antenna.readthedocs.io/en/latest/configuration.html

  I updated the Eliot (Mozilla Symbolication Service) docs:

  https://tecken.readthedocs.io/en/latest/configuration.html#symbolication-service-configuration-eliot


Why you should take a look at Everett
=====================================

Everett makes it easy to:

1. deal with different configurations between local development and
   server environments
2. write tests for configuration values
3. document configuration
4. debug configuration issues

First-class docs. First-class configuration error help. First-class testing.
This is why I created Everett.

If this sounds useful to you, take it for a spin. It's almost a drop-in
replacement for python-decouple and ``os.environ.get('CONFIGVAR', 'default_value')``
style of configuration so it's easy to test out.


Where to go for more
====================

For more specifics on this release, see here:
https://everett.readthedocs.io/en/latest/history.html#january-13th-2022

Documentation and quickstart here:
https://everett.readthedocs.io/

Source code and issue tracker here:
https://github.com/willkg/everett
