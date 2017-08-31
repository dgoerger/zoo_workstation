### installs and configures the XFCE Desktop Environment

unless node['zoo_workstation']['xfce']['packages'].empty?
  node['zoo_workstation']['xfce']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
