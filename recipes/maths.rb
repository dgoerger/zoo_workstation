### installs and configures commons shells

unless node['zoo_workstation']['maths']['packages'].empty?
  node['zoo_workstation']['maths']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
