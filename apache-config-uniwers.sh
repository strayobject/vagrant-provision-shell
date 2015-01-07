echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/uniwers\"
    ServerName dev.uniwers.net
    ErrorLog \"/var/log/apache2/error-uniwers.log\"
    <Directory /var/www/uniwers>
        <IfModule mod_rewrite.c>
            RewriteEngine on
#            RewriteRule  (.*) public/index.php [L]
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/uniwers.conf

if [ ! -d /home/vagrant/www/uniwers ];
then
    mkdir /home/vagrant/www/uniwers

    echo ">>> Cloning repos"
    git clone https://github.com/plainmotif/uniwers /home/vagrant/www/uniwers -o gh
    cd /home/vagrant/www/uniwers
    git remote rm gh
    git remote add gh git@github.com:plainmotif/uniwers.git
    /home/vagrant/bin/composer install -n
    git submodule init && git submodule update
    cp /home/vagrant/www/uniwers/config/config.json.sample /home/vagrant/www/uniwers/config/config.json
    sudo chmod 0777 /home/vagrant/www/uniwers/var
else
    cd /home/vagrant/www/uniwers
    git pull gh master
    /home/vagrant/bin/composer update -n
fi

sudo a2ensite uniwers

sudo service apache2 restart
