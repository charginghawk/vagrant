# charginghawk-vagrant

This is my lightweight vagrant setup for Drupal development on Mac OS X.
It installs all the requirements, along with xdebug, drush, and drupal console.
There's some server config too - clean URLs FTW.

# Using it

Install [vagrant](https://www.vagrantup.com/downloads.html) and [virtualbox](https://www.virtualbox.org/wiki/Downloads).

Set up a project directory with a structure like:
 - `project_directory`
 - `project_directory/`[`Vagrantfile`](Vagrantfile)
 - `project_directory/`[`bootstrap.sh`](bootstrap.sh)
 - `project_directory/`[`docroot`](docroot)`/<your site files>`

Edit the Vagrantfile to use a unique IP.

Then run `vagrant up` from the project directory, and you're off!
You can access the site at the IP you specified.

# Using it, extra stuff

Feel free to point a domain at that IP via your /etc/hosts file.

This is currently setup for D8. To use with D7 or D6, switch branches.

Works great with [Sequel Pro](http://www.sequelpro.com/) - just configure [like so](http://i.imgur.com/Q8bG2X2.png).

To use xdebug with PhpStorm, create a [server](http://i.imgur.com/kylD5wX.png), add a [run/debug configuration](http://i.imgur.com/qwhfCU9.png), and [turn it on](http://i.imgur.com/IAqsvZy.png).

# Caveats / Gotchas

You'll have to enter your password on `vagrant up` to edit /etc/exports.
[There are ways around this.](https://www.google.com/search?q=vagrant+nfs+password+skip)

If you accidentally reuse an IP, you may get an error like 'WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED'.
So, don't do that. But, you can also clean out your ~/.ssh/known_hosts.

This doesn't work with Windows, which doesn't support NFS.
[Learn more about synced folders.](https://docs.vagrantup.com/v2/synced-folders/index.html)

# See also

You should take 30 minutes and go through [Vagrant's getting started guide](https://docs.vagrantup.com/v2/getting-started/index.html).

[drupal-vm](http://www.drupalvm.com/) is a much larger and more powerful Drupal VM solution.

Check in on #vagrant on Freenode if you need help.

# @TODO

Move shell commands from bootstrap.sh into Vagrantfile, for even fewer files.
