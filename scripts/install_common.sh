#!/bin/bash
apt-get update -y
apt-get install -y net-tools
cat /home/vagrant/id_rsa.pub >>/home/vagrant/.ssh/authorized_keys
rm /home/vagrant/id_rsa.pub
chmod 600 /home/vagrant/.ssh/authorized_keys
echo "alias k='kubectl'" >>~/.bashrc
source ~/.bashrc
sudo apt-get install bash-completion -y
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
echo 'source <(kubectl completion bash)' >>~/.bashrc
