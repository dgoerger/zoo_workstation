### installs and configures MATE Desktop Environment

unless node['zoo_workstation']['mate']['packages'].empty?
  node['zoo_workstation']['mate']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
