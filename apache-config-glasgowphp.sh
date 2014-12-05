echo ">>> Configuring Server"
 
# Apache Config

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

    echo ">>> Cloning repos"
    git clone https://github.com/glasgowphp/site /home/vagrant/www/glasgowphp -o gh
    cd /home/vagrant/www/glasgowphp
    git remote rm gh
    git remote add gh git@github.com:glasgowphp/site.git
    /home/vagrant/bin/composer install -n
    git submodule init && git submodule update
    cp /home/vagrant/www/glasgowphp/config/config.json.sample /home/vagrant/www/glasgowphp/config/config.json
    sudo chmod 0777 /home/vagrant/www/glasgowphp/var
    cd content
    git pull origin master
else
    cd /home/vagrant/www/glasgowphp
    git pull gh master
    /home/vagrant/bin/composer update -n
    cd content 
    git pull origin master
fi

sudo a2ensite glasgowphp

sudo service apache2 restart
