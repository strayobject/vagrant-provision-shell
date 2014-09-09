echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/sochat\"
    ServerName dev.sochat.net
    ErrorLog \"/var/log/apache2/sochat-error.log\"
    <Directory /var/www/sochat>
        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/sochat.conf

if [ ! -d /home/vagrant/www/sochat ];
then
    mkdir /home/vagrant/www/sochat
fi

sudo a2dissite 000-default
sudo rm -rf /var/www
sudo ln -s /home/vagrant/www /var/www
#sudo setfacl -m u:www-data:rwx /var/www

sudo a2enmod rewrite
sudo a2ensite sochat

sudo service apache2 restart
