### installs various devel headers

unless node['zoo_workstation']['devel']['packages'].empty?
  node['zoo_workstation']['devel']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
