rirruto?
========

Rirruto turns your rss feeds into proper emails.

The goal is to define your mailing agent and feeds in a succinct ruby-esque fashion and have everything not suck horribly

Usage
=====

Mailers
-------

Mailers are defined as follows:

    class DefaultMailer < Rirruto::Mail::Profile
      username "happyuser"
      password "happyp4ss"
      server "localhost"
      port 25
      from "feh", "feh@notgmail.com"
      to "me", "me@notgmail.com"
    end

You can define multiple mail profiles if you so desire.
If you want a second mailer, just define another mailer class

    class SecondaryMailer < Rirruto::Mail::Profile
      ...
    end

Feeds
-----

Feeds are set up in the same fashion as mailers

    class Slashdot < Rirruto::Feed::Base
      url "http://rss.slashdot.org/Slashdot/slashdot"
      title "./" # set this to override the title feed. this is used in the subject of your emails
      mailer :default_mailer # this feed will use DefaultMailer 
      # creds 'user', 'pass' # define creds if your feed is behind http basic auth
    end

