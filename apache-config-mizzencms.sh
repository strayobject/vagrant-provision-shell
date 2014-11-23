echo ">>> Configuring Server"

# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzencms/mcmstest\"
    ServerName dev.mcmstest.net
    ErrorLog \"/var/log/apache2/error-mcmstest.log\"
    <Directory /var/www/mizzencms/mcmstest/>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/mcmstest.conf

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/mizzencms/site\"
    ServerName dev.mizzencms.net
    ErrorLog \"/var/log/apache2/error-mizzencms.log\"
    <Directory /var/www/mizzencms/site/>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/mizzencms.conf

if [ ! -d /home/vagrant/www/mizzencms ];
then
    mkdir /home/vagrant/www/mizzencms
fi

echo ">>> Cloning repos"

if [ ! -d /home/vagrant/www/mizzencms/mcmstest ];
then
    git clone https://github.com/mizzencms/skeleton.git /home/vagrant/www/mizzencms/mcmstest -o gh    
    cd /home/vagrant/www/mizzencms/mcmstest
    cp /home/vagrant/www/mizzencms/mcmstest/config/config.json.sample /home/vagrant/www/mizzencms/mcmstest/config/config.json
    git remote rm gh
    git remote add gh git@github.com:mizzencms/skeleton.git
    /home/vagrant/bin/composer install
    mv vendor/strayobject/mizzencms vendor/strayobject/mizzencms_orig
    ln -s /home/vagrant/www/mizzencms/core/src vendor/strayobject/mizzencms
else
    cd /home/vagrant/www/mizzencms/mcmstest    
    rm vendor/strayobject/mizzencms
    /home/vagrant/bin/composer update
    ln -s /home/vagrant/www/mizzencms/core/src vendor/strayobject/mizzencms
fi
if [ ! -d /home/vagrant/www/mizzencms/site ];
then
    git clone https://github.com/mizzencms/site.git /home/vagrant/www/mizzencms/site -o gh
    cd /home/vagrant/www/mizzencms/site
    cp /home/vagrant/www/mizzencms/site/config/config.json.sample /home/vagrant/www/mizzencms/site/config/config.json
    git remote rm gh
    git remote add gh git@github.com:mizzencms/site.git
    /home/vagrant/bin/composer install
else
    cd /home/vagrant/www/mizzencms/site
    git pull gh master
fi
if [ ! -d /home/vagrant/www/mizzencms/skeleton ];
then
    git clone https://github.com/mizzencms/skeleton.git /home/vagrant/www/mizzencms/skeleton -o gh
    cd /home/vagrant/www/mizzencms/skeleton
    cp /home/vagrant/www/mizzencms/skeleton/config/config.json.sample /home/vagrant/www/mizzencms/skeleton/config/config.json
    git remote rm gh
    git remote add gh git@github.com:mizzencms/skeleton.git
    /home/vagrant/bin/composer install
else
    cd /home/vagrant/www/mizzencms/skeleton
    git pull gh master
fi
if [ ! -d /home/vagrant/www/mizzencms/core ];
then
    git clone https://github.com/mizzencms/core.git /home/vagrant/www/mizzencms/core -o gh
    cd /home/vagrant/www/mizzzencms/core
    git remote rm gh
    git remote add gh git@github.com:mizzencms/core.git
    /home/vagrant/bin/composer install
else
    cd /home/vagrant/www/mizzencms/core
    git pull gh master
fi

sudo a2ensite mcmstest
sudo a2ensite mizzencms

sudo service apache2 restart
