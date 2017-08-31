### fun things

unless node['zoo_workstation']['fun_packages'].empty?
  node['zoo_workstation']['fun_packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

include_recipe 'zoo_workstation::desktop_cleanup'
