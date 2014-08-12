#!/usr/bin/env bash
 
echo ">>> Installing Composer"
 
# Composer
curl -sS https://getcomposer.org/installer | php
mkdir bin
mv composer.phar bin/composer
sudo chown -R vagrant:vagrant /home/vagrant/bin

echo ">>> Adding new dir to PATH"
echo PATH=\"\$HOME/.composer/vendor/bin/:\$PATH\" >> /home/vagrant/.profile

echo ">>> Installing globally"
# composer is not globally accessible in this session
bin/composer global require 'phpunit/phpunit=~4.2'
bin/composer global require 'gushphp/gush=dev-master'

# all above will be installed to /root/.composer so we move it back
sudo mv /root/.composer /home/vagrant/
chown -R vagrant:vagrant /home/vagrant/.composer