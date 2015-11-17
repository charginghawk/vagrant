#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
apt-get install -y curl
apt-get install -y git
apt-get install -y unzip
apt-get install -y php5
apt-get install -y php5-mysql
apt-get install -y php5-gd
apt-get install -y php5-curl
apt-get install -y php5-xdebug
apt-get install -y nfs-common
apt-get install -y nfs-kernel-server
# mysql username is root, no password
DEBIAN_PRIORITY=critical apt-get install -y mysql-server

# Install drush
if ! [ -x "$(command -v composer)" ]; then
    sudo curl -sS https://getcomposer.org/installer | php;
    ln -s /home/vagrant/composer.phar /usr/local/bin/composer;
fi
if ! [ -x "$(command -v drush)" ]; then
# Swap drush versions as appropriate
#    /home/vagrant/composer.phar global require drush/drush:7.*;
    /home/vagrant/composer.phar global require drush/drush:dev-master;
    mv /root/.composer /home/vagrant/;
    ln -s /home/vagrant/.composer/vendor/drush/drush/drush /usr/local/bin/drush;
fi

# Create symlink from /vagrant/docroot to /var/www/html (assuming site code is in 'docroot' directory)
if ! [ -L /var/www ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/docroot /var/www/html
fi

# Set server config
sed -i -- 's/AllowOverride None/AllowOverride all/g' /etc/apache2/apache2.conf
sed -i -- 's/128M/512M/g' /etc/php5/apache2/php.ini
echo 'xdebug.remote_enable = on' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_connect_back = on' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.max_nesting_level = 256' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.idekey = "vagrant"' >> /etc/php5/mods-available/xdebug.ini
a2enmod rewrite
service apache2 restart

# Install drupal console
curl -LSs http://drupalconsole.com/installer | php
mv console.phar /usr/local/bin/drupal

