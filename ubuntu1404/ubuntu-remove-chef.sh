#!/bin/bash
apt-get -y remove --purge chef
rm -rf /etc/chef
rm -rf /var/chef
rm -rf /opt/chef
history -c
history -w
shutdown -h now
