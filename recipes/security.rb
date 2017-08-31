### installs and configures software for security research

unless node['zoo_workstation']['security']['packages'].empty?
  node['zoo_workstation']['security']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
