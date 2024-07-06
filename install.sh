#!/usr/bin/env bash

# Check that ipset is installed
sudo apt install -y ipset

# Backup the original after.init configuration
sudo cp /etc/ufw/after.init /etc/ufw/after.init.backup

# Install the after.init configuration
sudo cp after.init /etc/ufw/after.init

# Set the cronjob to update the IP blocklist
sudo cp ufw-blocklist-ipsum /etc/cron.daily/ufw-blocklist-ipsum
sudo chown root:root /etc/ufw/after.init /etc/cron.daily/ufw-blocklist-ipsum
sudo chmod 750 /etc/ufw/after.init /etc/cron.daily/ufw-blocklist-ipsum

# Download the initial IP blocklist
curl -sS -f --compressed -o ipsum.1.txt 'https://raw.githubusercontent.com/stamparm/ipsum/master/levels/1.txt'
sudo chmod 640 ipsum.1.txt
sudo cp ipsum.1.txt /etc/ipsum.1.txt

# Start the service
sudo /etc/ufw/after.init start
