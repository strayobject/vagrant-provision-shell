#!/usr/bin/env bash

echo ">>> Starting Install Script"
 
echo ">>> Installing Base Items"
 
echo ">>> Adding PPA's and Installing Server Items"
 
# Add ppa
apt-add-repository ppa:chris-lea/node.js
 
# Update
sudo apt-get update
 
# Install the Rest
sudo apt-get install -y nodejs 
#curl https://npmjs.org/install.sh | sudo clean=no sh install.sh
wget https://www.npmjs.org/install.sh && sudo clean=no sh install.sh
