### installs and configures database software

unless node['zoo_workstation']['database']['packages'].empty?
  node['zoo_workstation']['database']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
