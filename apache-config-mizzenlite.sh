echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzenlite\"
    ServerName dev.mizzenlite.net
    ErrorLog \"/var/log/apache2/error-mizzenlite.log\"
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

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/plainmotif\"
    ServerName dev.plainmotif.net
    ErrorLog \"/var/log/apache2/error-plainmotif.log\"
    <Directory /var/www/plainmotif>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/plainmotif.conf

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/glasgowphp\"
    ServerName dev.glasgowphp.net
    ErrorLog \"/var/log/apache2/error-glasgowphp.log\"
    <Directory /var/www/glasgowphp>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/glasgowphp.conf

if [ ! -d /home/vagrant/www/glasgowphp ];
then
    mkdir /home/vagrant/www/glasgowphp
fi

if [ ! -d /home/vagrant/www/mizzenlite ];
then
    mkdir /home/vagrant/www/mizzenlite
fi

if [ ! -d /home/vagrant/www/plainmotif ];
then
    mkdir /home/vagrant/www/plainmotif
fi

sudo a2dissite 000-default
sudo rm -rf /var/www
sudo ln -s /home/vagrant/www /var/www
#sudo setfacl -m u:www-data:rwx /var/www

sudo a2enmod rewrite
sudo a2ensite mizzenlite
sudo a2ensite plainmotif 
sudo a2ensite glasgowphp

sudo service apache2 restart
