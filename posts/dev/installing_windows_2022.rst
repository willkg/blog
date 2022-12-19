.. title: Installing Windows (2022)
.. slug: installing_windows_2022
.. date: 2022-12-19 16:05:56 UTC-05:00
.. tags: dev, windows, mozilla
.. type: text

Installing Windows (2022)
=========================

I work at Mozilla. We get a laptop refresh periodically. I got a new laptop
that I was going to replace my older laptop with. I'm a software engineer and I
work on services that are built using Docker and tooling that runs on Linux.

This post covers my attempt at setting up a Windows laptop for software
development for the projects I work on after having spent the last 20 years
predominantly using Linux and Linux-like environments.

*Spoiler: This is a failed attempt and I gave up and stuck with Linux.*

.. TEASER_END


Wait, why write this?
=====================

Mozilla doesn't have a standard for how to set up a machine running Windows 11.
I figured I'd document it in my blog in case I make another attempt another
day.


Steps
=====

Basic setup based on "How to configure your new Windows Computer" which covers
Windows 10 and is pretty different.

Turn on machine:

1. Select country, locale, and keyboard layout.
2. Set up network.
3. Setup will ask you to choose a device name. Use ldapname hyphen asset tag.
   For example, mine would be something like "wkahngreene-11111".

   In my case, that's too long and I didn't want to drop the asset tag number
   or shorten my name because that gets confusing for me. So isntead, I used my
   nickname: "willkg-11111".

4. Set up an account.

   Microsoft *really* wants you to set up an online Microsoft Account. But we
   don't want to do that. So we follow the ridiculous steps in this article to
   set up a local account:

   https://beebom.com/how-create-local-account-windows-11/

   1. Use an account username that has no spaces so that your system works
      correctly with platforms like Treeherder. Make a note of username and
      password and put them into your password manager later.
   2. Choose  the recovery security questions you would like and provide
      answers for  them.  Make a note of these also so that you can upload
      them to your  password manager later for safekeeping.

5. Next is privacy settings. Set everything to "not share".
6. Once you're logged in, go to Windows Updates and update everything.

   * Note: This may involve multiple reboots and take a couple of hours.

7. Mozilla's instructions for Windows 10 suggest to remove the manufacturer
   system software because it can pose security risks.

   1. Go to Windows Settings -> Apps
   2. Find an item with "Dell" or "Lenovo" and then something like "System updater". For example, "Dell Command | System Updater".
   3. Uninstall that.

8. Reboot laptop.

Next to update security settings. This is based on "Windows 10 Client Security Checkup".

1. Go to Windows Update -> Advanced Options

   Turn on "Receive updates for other Microsoft products"

   Turn on "Notify me when a restart is required to finish updating"

2. Go to Privacy and Security -> Windows Security -> Virus and threat protection

   Make sure "Real-time protection", "Cloud-delivered protection", and
   "Automatic sample submission" are all on

3. Go to Personalization -> Power & battery

   In "Screen and sleep", make sure none of the situations are > 10 minutes

4. In Firewall & network protection

   Make sure the firewall is on for Domain network, Private network, and Public network.

5. Install a printer if you can
6. In Control Panel -> System and Security -> Bitlocker drive encryption

   Click on "Turn on Bitlocker" and print out the backup key

7. Make a installation media drive

Now to install the things I need to do my job.

1. Go to Taskbar settings

   Ditch widgets -- they need a Microsoft account and they're terrible

2. Unpin Microsoft programs from taskbar
3. Open Edge and use it to download and install Firefox
4. Install "App Installer" (aka winget) from the Microsoft Store
5. Open a Terminal with Powershell and install the following things:

   1. Install Firefox::

         winget install Mozilla.Firefox

   2. Install Microsoft PowerToys::

         winget install Microsoft.PowerToys

      Then remap capslock to left ctrl.

   3. Install Windows Terminal (preview)::

         winget install Microsoft.WindowsTerminal.Preview

      Then fix split-down to ctrl-shift-o and split-right to ctrl-shift-e like gnome-terminator.

      (https://learn.microsoft.com/en-us/windows/terminal/install)
 
   4. Install Slack::

         winget install SlackTechnologies.Slack

      Use SSO to log in.

   5. Install Element::
         
         winget install Element.Element

      Home server is "chat.mozilla.org"

   6. Install Zoom::

         winget install Zoom.Zoom

      Use SSO to log in.

   7. Install Evernote::

         winget install evernote.evernote

   8. Install 1Password::

         winget install AgileBits.1Password


   9. Install Docker::

         winget install Docker.DockerDesktop

      Get license.

   10. Install WSL::

          wsl --install

       From https://learn.microsoft.com/en-us/windows/wsl/install and
       https://learn.microsoft.com/en-us/windows/wsl/setup/environment

       Reboot and create login.

6. Open up a terminal in Ubuntu and start setting up my dev environment.


At this point, when copying files from the old laptop to the new lpatop, I
discovered the problem where wsl is a complete featherbrained nitwit and can't
keep track of time when the computer is sleeping.


wsl issue 8204
==============

If I have a wsl terminal open and I do the following:

1. type ``date`` and hit ENTER
2. put the computer to sleep
3. wait 5 minutes
4. wait the computer up
5. type ``date`` and hit ENTER

The second date suggests no time has passed at all. I can reliably reproduce
this [1]_.

.. [1] This was true until I slicked the laptop and installed Linux on it. Now
       I no longer have Windows installed.

This is covered in `issue 8204 <https://github.com/microsoft/WSL/issues/8204>`_
which was created in March 2022 and is still an issue that appears to have no
one looking into it. There are a couple of other issues in the issue tracker
spanning several years.

There are several workarounds mentioned. One of them is to type::

   sudo hwclock -s

whenever you wake up the computer. That doesn't work for me--it never fixed the
date correctly. Usually it got close. I had a couple of occasions where the
time ended up *in the future* which makes some tools really grumpy.

Another workaround is to set up systemd and timesyncd. You can only do it in
one wsl thing, though--don't do it in all of them. I thought about trying this
out, but then didn't.

Instead, I decided this is a complete non-starter for me. The tools I use need
to know wtf time it is. Updating the time via a scheduled task or manually
isn't good enough.


Options
=======

Given that I wanted to use wsl to do all my work and wsl wasn't working, I
figured I had a couple of options:

I could switch to doing all my work in a VM. I've done this in the past and I
could do this again, but I really didn't want to. It's usually frustrating.
Though this new machine has 32gb of RAM so maybe it'd be less of a pain in the
ass.

I could give up and continue using Linux. This wsl time issue is so wild that
it's hard not to see it as a sign that I shouldn't have even entertained the
notion of switching in the first place.

While I have things I don't like about Linux that I've largely grown numb to
and I'd have to continue using Zoom [2]_ on a separate machine, I decided this
was the best option for me. I just want to get my work done.


.. [2] Zoom, like Vidyo before it, crashes my computer. Generally, I've had a
       bad time with proprietary video conferencing software on Linux such that
       I've given up on it.


Conclusion
==========

I lost a few days of work figuring this out and I stuck with Linux.
