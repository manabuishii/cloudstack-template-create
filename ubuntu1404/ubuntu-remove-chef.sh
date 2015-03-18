#!/bin/bash
# RECOMMENDED
# export HISTSIZE=0
# run this script on /tmp
apt-get -y remove --purge chef
rm -rf /etc/chef
rm -rf /var/chef
rm -rf /opt/chef
rm /root/.ssh/authorized_keys
history -c
truncate -s 0 /root/.bash_history
shutdown -h now
