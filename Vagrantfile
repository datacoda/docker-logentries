# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# Before use:
# Create a file
# .envs.yml
# -----------
# logentries:
#   token: <API Token>

settings = YAML.load_file '.envs.yml'

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = "host/Vagrantfile"
    d.build_dir = "."
    d.has_ssh = false

    # docker run -it --name botlogger \
    #         -e LOG_FILTERS=Bots,Robots \
    #         -e TOKEN=aab98765-1234-123a-98ff-1a2b345a67bc \
    #         -v /var/run/docker.sock:/tmp/docker.sock \
    #         -v /var/lib/docker/containers:/var/lib/docker/containers \
    #         dataferret/logentries
    d.volumes = [
        "/var/run/docker.sock:/tmp/docker.sock",
        "/var/lib/docker/containers:/var/lib/docker/containers"
    ]
    d.env = {
        TOKEN: settings['logentries']['token'],
        LOG_FILTERS: "Bots,Robots"
    }
  end
end
