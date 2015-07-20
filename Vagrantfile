# -*- mode: ruby -*-
# vi: set ft=ruby :
# Original script on https://github.com/orendon/vagrant-rails

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu_precise64"
  # Forward rails server port to your host machine
  #
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Install linux packages
  #
  config.vm.provision :shell, path: "vagrant/vagrant_bootstrap.sh", privileged: false

  # Uncomment this line if you want to bundle install and setup/create database (optional)
  # The path: option accepts a script on your local filesystem in case you want to provide your own
  #
  # config.vm.provision :shell, path: "script/app_specifics.sh", privileged: false

  # Use an specific IP address on your local network
  #
  config.vm.network "private_network", ip: "192.168.33.10"

  # Share additional folders to the guest VM
  #
  config.vm.synced_folder '.', '/vagrant', nfs: true

  # Provider-specific configuration so you can fine-tune various
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #Vm comfig
  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
  end

end
