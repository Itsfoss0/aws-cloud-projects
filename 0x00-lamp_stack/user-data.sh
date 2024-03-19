#!/usr/bin/env bash

# user data script to install and 
# setup services when the instance
# spins up

sudo apt-get update --yes;
sudo apt-get install  apache2 php libapache2-mod-php php-mysql mysql-server --yes