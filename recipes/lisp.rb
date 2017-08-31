### installs and configures lisp

unless node['zoo_workstation']['lisp']['packages'].empty?
  node['zoo_workstation']['lisp']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
