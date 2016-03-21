# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

# Sets the IP where you can access the site
# Change the IP to unique value (usually by incrementing by 1, 5, or 10)
  config.vm.network "private_network", ip: "192.168.50.1"

# Choose what OS your VM will run, see: atlas.hashicorp.com/search
  config.vm.box = "ubuntu/wily64"

# Provisioning shell script
  config.vm.provision :shell, path: "bootstrap.sh"

# Syncs the the current directory with /vagrant on the guest machine, using nfs
  config.vm.synced_folder ".", "/vagrant", :nfs => true

# Gives the VM 2GB of RAM (which is too much, but I like to have breathing room)
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

end
