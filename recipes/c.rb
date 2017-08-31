### installs and configures gcc, clang, and related cross-compilers

unless node['zoo_workstation']['c']['packages'].empty?
  node['zoo_workstation']['c']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
