### installs and configures GNOME Desktop Environment

include_recipe 'zoo_workstation::gdm'

unless node['zoo_workstation']['gnome']['packages'].empty?
  node['zoo_workstation']['gnome']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
