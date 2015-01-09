echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/raid\"
    ServerName dev.raid.net
    ErrorLog \"/var/log/apache2/raid-error.log\"
    <Directory /var/www/raid>
        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/raid.conf

if [ ! -d /home/vagrant/www/raid ];
then
    mkdir /home/vagrant/www/raid
fi

sudo a2ensite raid

sudo service apache2 restart
