### installs and configures gcc, clang, and related cross-compilers

unless node['zoo_workstation']['haskell']['packages'].empty?
  node['zoo_workstation']['haskell']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
