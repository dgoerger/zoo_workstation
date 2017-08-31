### installs and configures software for robotics research

unless node['zoo_workstation']['robotics']['packages'].empty?
  node['zoo_workstation']['robotics']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
