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
