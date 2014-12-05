echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/magetest\"
    ServerName dev.magetest.net
    ErrorLog \"/var/log/apache2/magetest-error.log\"
    <Directory /var/www/magetest>
        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/magetest.conf

if [ ! -d /home/vagrant/www/magetest ];
then
    mkdir /home/vagrant/www/magetest
fi

sudo a2dissite 000-default
sudo rm -rf /var/www
sudo ln -s /home/vagrant/www /var/www
#sudo setfacl -m u:www-data:rwx /var/www

sudo a2enmod rewrite
sudo a2ensite magetest

sudo service apache2 restart
