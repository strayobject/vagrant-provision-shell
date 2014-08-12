echo ">>> Setting up Vim"

sudo apt-get install -y vim

# Grab my .vimrc and set owner
git clone https://strayobject@bitbucket.org/strayobject/vim.git /home/vagrant/.vim

sudo chown -R vagrant:vagrant /home/vagrant/.vim

ln -s /home/vagrant/.vim/vimrc /home/vagrant/.vimrc
sudo chown vagrant:vagrant /home/vagrant/.vimrc