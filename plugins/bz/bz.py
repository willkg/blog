"""
Bugzilla plugin that provides a bz role.

Usage::

    :bz:`1007840`

This will create a link to the bug with the text ``[bug #]``.

"""

from docutils import nodes
from docutils.parsers.rst import roles

from nikola.plugin_categories import RestExtension
from nikola.utils import req_missing


URL = 'https://bugzil.la/{bugid}'


def mozbug_ref_role(role, rawtext, text, lineno, inliner, options=None,
                    content=None):
    options = options or {}
    content = content or []

    try:
        bugid = int(text)
        if bugid <= 0:
            raise ValueError
    except ValueError:
        msg = inliner.reporter.error(
            'Bug id must be a positive integer. "{0}" is invalid'.format(text),
            line=lineno
        )
        prb = inliner.problematic(rawtext, rawtext, msg)
        return [prb], [msg]

    url = URL.format(bugid=bugid)

    # set_classes(options)
    node = nodes.reference(rawtext, '[bug {0}]'.format(bugid), refuri=url, **options)
    return [node], []


class Plugin(RestExtension):
    name = 'rest_bz'

    def set_site(self, site):
        self.site = site
        roles.register_canonical_role('bz-reference', mozbug_ref_role)
        return super(Plugin, self).set_site(site)


# Hack so that we don't have to modify that file.
from docutils.parsers.rst.languages import en
en.roles['bz'] = 'bz-reference'
