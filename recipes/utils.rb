### installs and configures commons shells

unless node['zoo_workstation']['utils']['packages'].empty?
  node['zoo_workstation']['utils']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
