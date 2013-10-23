Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "precise64"

  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt", "/srv/salt/"
  config.vm.synced_folder "pillar", "/srv/pillar/"

  ## Use all the defaults:
  config.vm.provision :salt do |salt|

    salt.minion_config = "minion.conf"
    salt.run_highstate = true

  end
end
