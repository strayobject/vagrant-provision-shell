echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzenlite\"
    ServerName dev.mizzenlite.net
    ErrorLog \"/var/log/apache2/mizzenlite-error.log\"
    <Directory /var/www/mizzenlite>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/mizzenlite.conf

if [ ! -d /home/vagrant/www/mizzenlite ];
then
    mkdir /home/vagrant/www/mizzenlite
fi

sudo a2dissite 000-default
sudo rm -rf /var/www
sudo ln -s /home/vagrant/www /var/www
#sudo setfacl -m u:www-data:rwx /var/www

sudo a2enmod rewrite
sudo a2ensite mizzenlite

sudo service apache2 restart
