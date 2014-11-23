echo ">>> Configuring Server"
 
# Apache Config

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


if [ ! -d /home/vagrant/www/plainmotif ];
then
    mkdir /home/vagrant/www/plainmotif
    
    echo ">>> Cloning repos"
    git clone https://github.com/plainmotif/site /home/vagrant/www/plainmotif -o gh
    cd /home/vagrant/www/plainmotif
    git remote rm gh
    git remote add gh git@github.com:plainmotif/site.git
    /home/vagrant/bin/composer install
    cp /home/vagrant/www/plainmotif/config/config.json.sample /home/vagrant/www/plainmotif/config/config.json
    sudo chmod 0777 /home/vagrant/www/plainmotif/var

else
    cd /home/vagrant/www/plainmotif
    git pull gh master
    /home/vagrant/bin/composer update
fi

sudo a2ensite plainmotif 

sudo service apache2 restart

