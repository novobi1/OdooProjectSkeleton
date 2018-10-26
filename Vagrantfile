# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ThyDao/odoo-box"
  config.vm.hostname = "odoo-vagrant"
  config.vm.network "private_network", ip: "192.168.100.10"
  config.vm.synced_folder ".", "/opt/odoo", owner: "odoo", group: "odoo", :mount_options => ["dmode=777", "fmode=777"]
end
