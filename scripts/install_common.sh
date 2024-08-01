#!/bin/bash
cat /home/vagrant/id_rsa.pub >>/home/vagrant/.ssh/authorized_keys
rm /home/vagrant/id_rsa.pub
chmod 600 /home/vagrant/.ssh/authorized_keys
echo "alias k='kubectl'" >>~/.bashrc
