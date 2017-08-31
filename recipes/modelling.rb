### installs and configures 3D modelling software

unless node['zoo_workstation']['modelling']['packages'].empty?
  node['zoo_workstation']['modelling']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
