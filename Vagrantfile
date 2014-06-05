# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos_65_x64_puppet"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = true
  end

  config.vm.define :goserver do |server|
    server.vm.network :private_network, ip: "192.168.10.100"
    server.vm.hostname = "goserver"
    server.vm.network :forwarded_port, guest: 8153, host: 8153
    server.vm.provision :hosts

    server.vm.provision :puppet do |puppet|
      puppet.manifest_file = "local-ci.pp"
      puppet.module_path = 'modules'
      puppet.options = '--verbose --debug'
      puppet.hiera_config_path = 'hiera.yaml'
    end
  end

  config.vm.define :goagent do |agent|
    agent.vm.network :private_network, ip: "192.168.10.101"
    agent.vm.hostname = "goagent"
    agent.vm.provision :hosts

    agent.vm.provision :puppet do |puppet|
      puppet.manifest_file = "local-ci.pp"
      puppet.module_path = 'modules'
      puppet.options = '--verbose --debug'
      puppet.hiera_config_path = 'hiera.yaml'
    end
  end


end
