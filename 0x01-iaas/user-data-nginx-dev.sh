#!/usr/bin/env bash

# install nginx and start the nginx service
# with systemd (init script)

sudo apt-get update --yes
sudo apt-get install nginx --yes
sudo systemctl enable --now nginx.service