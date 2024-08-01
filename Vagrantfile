# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    name_group = "KUBERNETES"
    machines = [
    { 
        vmbox: "bento/ubuntu-20.04", 
        name: 'master', 
        networkname: 'net2', 
        ip: '192.168.1.160',
        ip_private: '10.0.0.10',
        mask: '255.255.255.0',
        provision:'scripts/null.sh',
        port_guest: 8000,
        port_host: 8000
      },
      { 
        vmbox: "bento/ubuntu-20.04", 
        name: 'worker1', 
        networkname: 'net1', 
        ip: '192.168.1.161',
        ip_private: '10.0.0.11',
        mask: '255.255.255.0',
        provision:'scripts/null.sh',
        port_guest: 8001,
        port_host: 8001
      }
    ]
  
  machines.each do |each_machine|	
      config.vm.define each_machine[:name] do |node|
        node.vm.provision "shell", inline: <<-SHELL
          apt-get update -y
          apt-get install -y net-tools
          echo "#{each_machine[:ip]}  #{each_machine[:name]}" >> /etc/hosts
        SHELL
        node.vm.boot_timeout = 360
        node.ssh.username = "vagrant"
        node.ssh.password = "vagrant"
        config.ssh.insert_key = true
        node.ssh.forward_agent = true
        node.vm.box = each_machine[:vmbox]
        node.vm.network "public_network", ip: each_machine[:ip], bridge: "Realtek PCIe GbE Family Controller #3"
        node.vm.hostname = each_machine[:name]
        #######################################
        node.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--groups", "/#{name_group}"]
          vb.cpus = 2
          vb.memory = "2048"
        end
        if each_machine[:name] == 'master'
          node.vm.provision "kubernetes", type: "shell", path: "scripts/bootstrap-master.sh"
        else
          node.vm.provision "kubernetes", type: "shell", path: "scripts/bootstrap-worker.sh"
        end
        node.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/id_rsa.pub"
        node.vm.provision "common", type: "shell", path: "scripts/install_common.sh"
        node.vm.synced_folder "C:/MyDocuments/Programming/vagrants/vagrant/shared_folder", "/home/vagrant/shared_folder"
        # node.vm.network "private_network", ip: each_machine[:ip_private], auto_config: true, virtualbox__intnet: each_machine[:networkname]
        
        node.vm.provision "shell", run: 'always', inline: <<-SHELL
          sudo ip route del default
          sudo route add default gw 192.168.1.1
        SHELL
      end 
    end
  end