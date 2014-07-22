#!/bin/bash
# PREREQUIRED
#  NIC setting done by hand
#   HWADDR macaddress
#   UUID   for NetworkManager ?
# RECOMMENDED
#  export HISTSIZE=0
#  run this script on /tmp
# TODO
#  UUID of disk
#  for ext2,3,4 tunee2fs -U `/usr/bin/uuidgen` device
yum update -y
grubby --update-kernel=ALL --remove-args="rhgb quiet"

rm -vf /etc/udev/rules.d/70-persistent-net.rules

yum remove -y NetworkManager fcoe-utils lldpad

rm -vf \
  /etc/ssh/{ssh_host_dsa_key.pub,ssh_host_dsa_key} \
  /etc/ssh/{ssh_host_rsa_key.pub,ssh_host_rsa_key} \
  /etc/ssh/{ssh_host_key.pub,ssh_host_key} \
  /etc/ssh/{ssh_host_ecdsa_key.pub,ssh_host_ecdsa_key}

rm -vf /root/.ssh/known_hosts


truncate -s 0 \
  /var/log/maillog \
  /var/log/messages \
  /var/log/secure \
  /var/log/spooler \
  /var/log/dracut.log \
  /var/log/lastlog \
  /var/log/wtmp \
  /var/log/cron

chkconfig blk-availability off
chkconfig iscsi off
chkconfig iscsid off

yum clean all

# guest password
#curl https://github.com/shankerbalan/cloudstack-scripts/raw/master/cloud-set-guest-password-centos -o /etc/init.d/cloud-set-guest-password
#chmod +x /etc/init.d/cloud-set-guest-password
#chkconfig --add cloud-set-guest-password


# remove HWADDR, UUID maybe NM_CONTROLLED is not needed
#sed '/^HWADDR=/d' /etc/sysconfig/network-scripts/ifcfg-eth0 | sed '/^UUID=/d' > /tmp/ifcfg-eth0
#mv /tmp/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
BOOTPROTO=dhcp
ONBOOT=yes
EOF

history -c
truncate -s 0 /root/.bash_history
#shutdown -h now
rm /tmp/setup_for_template.sh
halt -p
