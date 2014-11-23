#!/usr/bin/env bash

echo ">>> Starting Install Script"
 
# Update
sudo apt-get update
sudo apt-get upgrade
 
echo ">>> Installing Base Items"
 
# Install base items
# python-software-properties required to fix missing add-apt-repository
sudo apt-get install -y python-software-properties
 
echo ">>> Adding PPA's and Installing Server Items"
 
# Add repo for latest PHP
sudo add-apt-repository -y ppa:ondrej/php5
 
# Update Again
sudo apt-get update
 
# Install the Rest
sudo apt-get install -y curl php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt

# PHP Config
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini


sudo a2dissite 000-default
sudo rm -rf /var/www
sudo ln -s /home/vagrant/www /var/www
sudo a2enmod rewrite

sudo service apache2 restart
