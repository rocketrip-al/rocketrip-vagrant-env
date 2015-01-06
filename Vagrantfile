# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "ubuntu/trusty64"
BOX_URI = ENV['BOX_URI'] || "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"

SSH_PRIVKEY_PATH = ENV["SSH_PRIVKEY_PATH"]

HOST_PROJECT_ROOT = '/Users/alnguyen/projects/rocketrip'
GUEST_PROJECT_ROOT = '/app'

Vagrant.configure(2) do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  # Use the specified private key path if it is specified and not empty.
  if SSH_PRIVKEY_PATH
      config.ssh.private_key_path = SSH_PRIVKEY_PATH
  end

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb, override|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, :path => "setup.sh"

  config.vm.synced_folder HOST_PROJECT_ROOT, GUEST_PROJECT_ROOT

  config.vm.network :forwarded_port, :host => 8000, :guest => 8000

  # MySQL port
  config.vm.network :forwarded_port, :host => 3306, :guest => 3306
end
