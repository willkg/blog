.. title: PyBlosxom status: 12/06/2005
.. slug: status.12062005
.. date: 2005-12-06 12:16:35
.. tags: pyblosxom, dev, python

I've been running my blog on the latest code and keeping track of all
exceptions that get thrown and any other odd issues and things seem
to be going well.  As such, I'll be preparing to do a release candidate
soon and then start the mildly painful process of re-writing the
appropriate sections of the PyBlosxom manual.

I'm also taking some time to run 
`Cheesecake <http://tracos.org/cheesecake>`_ against the codebase.
The results so far are somewhat of a bummer::

    [cheesecake:console] Detailed info available in log file /tmp/cheesecake_sandbox 
    /pyblosxom-1.3.tar.gz.log
    [cheesecake:console] A given package can currently reach a MAXIMUM number of 560 points
    [cheesecake:console] Starting computation of Cheesecake index for package 
    'pyblosxom-1.3.tar.gz'
    index_unpack ..................  25 (package untar-ed successfully)
    index_unpack_dir ..............  15 (unpack directory is pyblosxom-1.3 as expected)
    index_install .................   0 (could not install package in 
    /tmp/cheesecake_sandbox/tmp_install_pyblosxom-1.3)
    index_file_announce ...........   0 (file not found)
    index_file_changelog ..........  10 (file found)
    index_file_ez_setup.py ........   0 (file not found)
    index_file_faq ................   0 (file not found)
    index_file_install ............  10 (file found)
    index_file_license ............  10 (file found)
    index_file_news ...............   0 (file not found)
    index_file_pkg-info ...........  10 (file found)
    index_file_readme .............  15 (critical file found)
    index_file_setup.py ...........  15 (critical file found)
    index_file_thanks .............   0 (file not found)
    index_file_todo ...............   0 (file not found)
    index_dir_demo ................   0 (directory not found)
    index_dir_doc .................  25 (critical directory found)
    index_dir_example .............   0 (directory not found)
    index_dir_test ................   0 (directory not found)
    index_docstrings ..............  70 (found 264/382=69.11% modules/classes/methods/functions 
    with docstrings)
    index_pylint ..................  68 (average score is 6.77 out of 10)
    ===================================
    ABSOLUTE CHEESECAKE INDEX ..... 273
    RELATIVE CHEESECAKE INDEX .....  48 (273 out of a maximum of 560 points is 48%)

So, 273 out of 560...  Could be worse, but should be a lot better.
