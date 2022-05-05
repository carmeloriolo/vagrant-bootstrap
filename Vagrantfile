# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file(ENV['VG_MACHINE_CONFIG_PATH'])['configs']

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.define configs['name'] do |t|
  end

  if configs['network'] == 'private'
    config.vm.network "private_network", ip: configs['private_ip_address']
  end

  config.vm.box = configs['box']

  config.vm.provider "virtualbox" do |vb|
    # VirtualBox displayed name
    vb.name = configs['name']
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = configs['memory']
    vb.cpus = configs['cpus']
  end

  config.vm.synced_folder "~/Dev", "/home/vagrant/dev"

  # Bootstrap
  config.vm.provision "bootstrap", type: "ansible" do |ansible|
    ansible.playbook = "#{configs['playbooks_prefix']}/bootstrap.yml"
  end

  # Install Docker
  config.vm.provision "docker", type: "ansible", run: configs['install_docker'] do |ansible|
    ansible.playbook = "#{configs['playbooks_prefix']}/docker.yml"
  end

  # Install Kubeadm
  config.vm.provision "kubeadm", type: "ansible", run: configs['install_kubeadm'] do |ansible|
    ansible.playbook = "#{configs['playbooks_prefix']}/kubeadm.yml"
  end

  # Install Go
  config.vm.provision "go", type: "shell", run: configs['install_go'] do |s|
    s.path = "#{configs['scripts_prefix']}/setup-go.sh"
    s.args = "#{configs['go_version']}"
  end
end
