echo ">>> Installing Git"
sudo apt-get install -y git-core

# Git Config and set Owner
echo "[user]" >> /home/vagrant/.gitconfig
echo "name = Michal Zdrojewski" >> /home/vagrant/.gitconfig
echo "email = code@strayobject.co.uk" >> /home/vagrant/.gitconfig
echo "[core]" >> /home/vagrant/.gitconfig
echo "excludesfile = /home/vagrant/.gitignore_global" >> /home/vagrant/.gitconfig

echo "nbproject" >> /home/vagrant/.gitignore_global
echo ".project" >> /home/vagrant/.gitignore_global
echo ".settings" >> /home/vagrant/.gitignore_global
echo ".DS_STORE" >> /home/vagrant/.gitignore_global
echo "_notes" >> /home/vagrant/.gitignore_global
echo "dwsync.xml" >> /home/vagrant/.gitignore_global
echo "thumbs.db" >> /home/vagrant/.gitignore_global
echo ".svn" >> /home/vagrant/.gitignore_global
echo "*.swp" >> /home/vagrant/.gitignore_global

sudo chown vagrant:vagrant /home/vagrant/.gitconfig
sudo chown vagrant:vagrant /home/vagrant/.gitignore_global

