echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/techcal\"
    ServerName dev.techcal.net
    ErrorLog \"/var/log/apache2/techcal-error.log\"
    <Directory /var/www/techcal>
        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/techcal.conf

if [ ! -d /home/vagrant/www/techcal ];
then
    mkdir /home/vagrant/www/techcal
fi

sudo a2ensite techcal

sudo service apache2 restart
