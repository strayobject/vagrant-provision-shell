echo ">>> Configuring Server"
 
# Apache Config

sudo echo "<VirtualHost *:80>
    DocumentRoot \"/var/www/icstrans\"
    ServerName dev.icstrans.net
    ErrorLog \"/var/log/apache2/error-icstrans.log\"
    <Directory /var/www/icstrans>
        <IfModule mod_rewrite.c>
            RewriteEngine on
        </IfModule>

        # Prevent file browsing
        Options -Indexes
        AllowOverride all
    </Directory>

</VirtualHost>" >> /etc/apache2/sites-available/icstrans.conf


if [ ! -d /home/vagrant/www/icstrans ];
then
    mkdir /home/vagrant/www/icstrans
    
    echo ">>> Cloning repos"
    git clone https://github.com/strayobject/icstrans.git /home/vagrant/www/icstrans -o gh
    cd /home/vagrant/www/icstrans
    git remote set-url gh git@github.com:strayobject/icstrans.git
else
    cd /home/vagrant/www/icstrans
    git pull gh master
fi

sudo a2ensite icstrans 

sudo service apache2 restart

