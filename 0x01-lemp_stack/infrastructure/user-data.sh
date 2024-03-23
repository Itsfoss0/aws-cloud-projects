#!/usr/bin/env bash

# user data script to install and
# setup services when the instance
# spins up

sudo hostnamectl set-hostname lemp-02
sudo apt-get update --yes
sudo apt-get install nginx php php-fpm libapache2-mod-php php-mysql mysql-server --yes

sudo mkdir /var/www/projectlemp
sudo chown -R "$USER:$USER" /var/www/projectlemp/
