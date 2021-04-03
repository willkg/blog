.. title: miro and sun-java6-plugin conflict clarification
.. slug: miro_and_sun_java6_plugin_conflict_clarification
.. date: 2007-10-24 13:22:03
.. tags: miro, work

I want to clarify the situation with Miro and the ``sun-java6-plugin``
package.

Prior to 0.9.9.9, if you had the ``sun-java6-plugin`` installed and you
install Miro, then Miro would crash on startup. For 0.9.9.9, we added a
conflict with the ``sun-java6-plugin`` package. That means that in order
to install Miro, you will have to uninstall the ``sun-java6-plugin``.

I've gotten a lot of flack for this fix in the last couple of days--and
for good reason: this sucks for users who have that plugin installed. I
definitely understand the frustration and we don't consider this a final
solution. (As a philosophical note, most development solutions are not
final--most things can be changed if a better feasible option is found
and implemented.)

The bottom line is that if you use the ``sun-java6-plugin`` plugin, you
can't use Miro. Adding the conflict line to the package makes it more
user-friendly when installing Miro because then you're not stuck in a
situation where you have installed Miro, it crashes on startup, and you
have no clue why.

We're interested in a real solution for this problem. Details of the
problem are in these bugs:

* `bug 5092 <http://bugzilla.pculture.org/show_bug.cgi?id=5092>`__
* `bug 8444 <http://bugzilla.pculture.org/show_bug.cgi?id=8444>`__
* `bug 9064 <http://bugzilla.pculture.org/show_bug.cgi?id=9064>`__

If you have feasible ideas, add them in the comments on `bug
9064 <http://bugzilla.pculture.org/show_bug.cgi?id=9064>`__ or comment
here.
