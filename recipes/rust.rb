### installs and configures rust

unless node['zoo_workstation']['rust']['packages'].empty?
  node['zoo_workstation']['rust']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
