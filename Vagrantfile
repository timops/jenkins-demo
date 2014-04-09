#require 'berkshelf/vagrant'

OMNIBUS_CHEF_VERSION = '11.4.0'

Vagrant::Config.run do |config|
  # The path to the Berksfile to use with Vagrant Berkshelf
  #config.berkshelf.berksfile_path = "./Berksfile"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  config.vm.define :master do |master_config|
    master_config.vm.host_name = "jenkins-master"
    master_config.vm.box = "opscode-ubuntu-12.04"
    master_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"

    master_config.vm.network :hostonly, "172.16.65.200"
    master_config.ssh.max_tries = 40
    master_config.ssh.timeout   = 120
    master_config.ssh.forward_agent = true

    # uncomment to use vagrant shell provisioner to get lateste Chef-client.
=begin
    master_config.vm.provision :shell, :inline => <<-INSTALL_OMNIBUS
    if [ ! -d '/opt/chef' ] || 
       [ ! $(chef-solo --v | awk "{print \\$2}") = "#{OMNIBUS_CHEF_VERSION}" ]
    then
       wget -qO- https://www.opscode.com/chef/install.sh | sudo bash -s -- -v "#{OMNIBUS_CHEF_VERSION}"
    else
       echo "Chef #{OMNIBUS_CHEF_VERSION} already installed...skipping installation."
    fi 
    INSTALL_OMNIBUS
=end

    master_config.vm.provision :chef_client do |chef|
      chef.json = {
        :jenkins => {

        }
      }
      chef.chef_server_url = "https://api.opscode.com/organizations/persuse"

      chef.validation_client_name = "persuse-validator"
      chef.validation_key_path = "#{ENV['HOME']}/.chef/persuse-validator.pem"
      chef.client_key_path = "/etc/chef/client.pem"

      chef.run_list = [
        "recipe[apt]",
        "recipe[jenkins-demo::server]"
      ]
    end
  end

  config.vm.define :slave do |slave_config|
    slave_config.vm.host_name = "jenkins-slave"
    slave_config.vm.box = "opscode-ubuntu-12.04"
    slave_config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"

    slave_config.vm.network :hostonly, "172.16.65.201"
    slave_config.ssh.max_tries = 40
    slave_config.ssh.timeout   = 120
    slave_config.ssh.forward_agent = true

    slave_config.vm.provision :chef_client do |chef|
      chef.json = {
        :jenkins => {
          :server => {
            :port => 8080,
            :host => "172.16.65.200",
            :url => "http://172.16.65.200:8080"
          }
        }
      }
      chef.chef_server_url = "https://api.opscode.com/organizations/persuse"

      chef.validation_client_name = "persuse-validator"
      chef.validation_key_path = "#{ENV['HOME']}/.chef/persuse-validator.pem"
      chef.client_key_path = "/etc/chef/client.pem"

      chef.run_list = [
        "recipe[apt]",
        "recipe[jenkins-demo::node_jnlp]"
      ]
    end
  end
end
