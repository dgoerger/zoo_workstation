### installs and configures R

include_recipe 'zoo_workstation::zoo_repo'

unless node['zoo_workstation']['r']['packages'].empty?
  node['zoo_workstation']['r']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

cookbook_file '/usr/lib64/R/etc/Rprofile.site' do
  source 'Rprofile.site'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
