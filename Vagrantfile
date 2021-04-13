# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/debian10"
  config.ssh.insert_key = false
  config.vm.provider "virtualbox"
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Define three VMs with static private IP addresses.
  boxes = [
    { :name => "node1",       :ip => "192.168.40.100",  :cpu => 1,   :memory => 1024},
  ]

  # Configure each of the VMs.
  boxes.each_with_index do |opts, index|
    config.vm.define opts[:name] do |config|
      # config.vm.hostname = opts[:name] + ".cluster.test"
      config.vm.network :private_network, ip: opts[:ip]


      config.vm.provider :virtualbox do |v|
        v.memory =  opts[:memory]
        v.cpus = opts[:cpu]
        v.linked_clone = true
        v.customize ['modifyvm', :id, '--audio', 'none']
      end


      # Provision all the VMs using Ansible after last VM is up.
      if index == boxes.size - 1
        config.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "playbook.yml"
          ansible.inventory_path = "inventory"
          ansible.limit = "all"
        end
      end
    end
  end

end
