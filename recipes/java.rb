### installs and configures java

unless node['zoo_workstation']['java']['packages'].empty?
  node['zoo_workstation']['java']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
