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

# Install mysql
DEBIAN_PRIORITY=critical apt-get install -y mysql-server
mysql -uroot -e "create database vagrant;"

# Install composer
if ! [ -x "$(command -v composer)" ]; then
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer;
fi

# Install drush
if ! [ -x "$(command -v drush)" ]; then
    wget http://files.drush.org/drush.phar
    chmod +x drush.phar
    mv drush.phar /usr/local/bin/drush
fi

# Install drupal console
if ! [ -x "$(command -v drupal)" ]; then
    curl https://drupalconsole.com/installer -L -o drupal.phar
    mv drupal.phar /usr/local/bin/drupal
    chmod +x /usr/local/bin/drupal
fi

# Create symlink from /vagrant/docroot to /var/www/html (assuming site code is in 'docroot' directory)
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/docroot /var/www/html
fi

# Set server config
sed -i -- 's/AllowOverride None/AllowOverride all/g' /etc/apache2/apache2.conf
sed -i -- 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php5/apache2/php.ini
sed -i -- 's/upload_max_filesize = 2M/upload_max_filesize = 256M/g' /etc/php5/apache2/php.ini
sed -i -- 's/post_max_size = 8M/post_max_size = 256M/g' /etc/php5/apache2/php.ini
echo 'xdebug.remote_enable = on' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_connect_back = on' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.max_nesting_level = 256' >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.idekey = "PHPSTORM"' >> /etc/php5/mods-available/xdebug.ini
a2enmod rewrite
service apache2 restart

echo "mysql credentials: username: root, database: vagrant, no password.";

