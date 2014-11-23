echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzenlite/mizzenlite\"
    ServerName dev.mizzenlite-test.net
    ErrorLog \"/var/log/apache2/error-mizzenlitetest.log\"
    <Directory /var/www/mizzenlite/mizzenlite/>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/mizzenlitetest.conf

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzenlite/site\"
    ServerName dev.mizzenlite.net
    ErrorLog \"/var/log/apache2/error-mizzenlite.log\"
    <Directory /var/www/mizzenlite/site/>
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

if [ ! -d /home/vagrant/www/mizzenlite/mizzenlite ];
then
    echo ">>> Cloning repos"
    git clone https://github.com/mizzenlite/skeleton.git /home/vagrant/www/mizzenlite/mizzenlite -o gh
    git clone https://github.com/mizzenlite/skeleton.git /home/vagrant/www/mizzenlite/site -o gh
    git clone https://github.com/mizzenlite/skeleton.git /home/vagrant/www/mizzenlite/skeleton -o gh
    git clone https://github.com/mizzenlite/core.git /home/vagrant/www/mizzenlite/core -o gh
    
    cd /home/vagrant/www/mizzenlite/mizzenlite
    cp /home/vagrant/www/mizzenlite/mizzenlite/config/config.json.sample /home/vagrant/www/mizzenlite/mizzenlite/config/config.json
    /home/vagrant/bin/composer install
    mv vendor/strayobject/mizzenlite vendor/strayobject/mizzenlite_orig
    ln -s /home/vagrant/www/mizzenlite/core/src vendor/strayobject/mizzenlite
    
    cd /home/vagrant/www/mizzenlite/site
    cp /home/vagrant/www/mizzenlite/site/config/config.json.sample /home/vagrant/www/mizzenlite/site/config/config.json
    /home/vagrant/bin/composer install

else
    cd /home/vagrant/www/mizzenlite/core
    git pull gh master
    cd /home/vagrant/www/mizzenlite/site
    git pull gh master
    cd /home/vagrant/www/mizzenlite/skeleton
    git pull gh master
    cd /home/vagrant/www/mizzenlite/mizzzenlite
    
    rm vendor/strayobject/mizzenlite
    /home/vagrant/bin/composer update
    ln -s /home/vagrant/www/mizzenlite/core/src vendor/strayobject/mizzenlite
fi


sudo a2ensite mizzenlitetest
sudo a2ensite mizzenlite

sudo service apache2 restart
