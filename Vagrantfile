# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "ubuntu"
BOX_URI = ENV['BOX_URI'] || "http://files.vagrantup.com/precise64.box"

SSH_PRIVKEY_PATH = ENV["SSH_PRIVKEY_PATH"]

HOST_PROJECT_ROOT = '/Users/alnguyen/projects/rocketrip'
GUEST_PROJECT_ROOT = '/app'

$script = <<SCRIPT
# Packaged dependencies
apt-get update
export DEBIAN_FRONTEND=noninteractive  # for mysql install
apt-get install -yq \
	build-essential \
	python-dev \
	curl \
	libmysqlclient-dev \
	mysql-server \
	python-pip \
	tmux \
	--no-install-recommends

# Need to upgrade `distribute` before pip can install Django.
easy_install -U distribute 
pip install -r #{GUEST_PROJECT_ROOT}/requirements.txt
SCRIPT

$vbox_script = $script

Vagrant::Config.run do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  # Use the specified private key path if it is specified and not empty.
  if SSH_PRIVKEY_PATH
      config.ssh.private_key_path = SSH_PRIVKEY_PATH
  end

  config.ssh.forward_agent = true
end

# Providers were added on Vagrant >= 1.1.0
#
# NOTE: The vagrant "vm.provision" appends its arguments to a list and executes
# them in order.  If you invoke "vm.provision :shell, :inline => $script"
# twice then vagrant will run the script two times.  Unfortunately when you use
# providers and the override argument to set up provisioners (like the vbox
# guest extensions) they 1) don't replace the other provisioners (they append
# to the end of the list) and 2) you can't control the order the provisioners
# are executed (you can only append to the list).  If you want the virtualbox
# only script to run before the other script, you have to jump through a lot of
# hoops.
#
# Here is my only repeatable solution: make one script that is common ($script)
# and another script that is the virtual box guest *prepended* to the common
# script.  Only ever use "vm.provision" *one time* per provider.  That means
# every single provider has an override, and every single one configures
# "vm.provision".  Much saddness, but such is life.
Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb, override|
    override.vm.provision :shell, :inline => $vbox_script
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.synced_folder HOST_PROJECT_ROOT, GUEST_PROJECT_ROOT

  (8000..8099).each do |port|
    config.vm.network :forwarded_port, :host => port, :guest => port
  end

  # MySQL port
  config.vm.network :forwarded_port, :host => 3306, :guest => 3306
end
