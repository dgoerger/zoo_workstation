### installs and configures TeX Live

unless node['zoo_workstation']['texlive']['packages'].empty?
  node['zoo_workstation']['texlive']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
