### installs and configures erlang deps

unless node['zoo_workstation']['erlang']['packages'].empty?
  node['zoo_workstation']['erlang']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
