
sudo apt-get install php5-dev gcc

echo ">>> Setting up Phalcon"

git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install

echo "" >> /etc/php5/apache2/php.ini
echo "extension=phalcon.so"  >> /etc/php5/apache2/php.ini

sudo service apache2 restart
