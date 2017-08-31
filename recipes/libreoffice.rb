### installs and configures libreoffice

unless node['zoo_workstation']['libreoffice_packages'].empty?
  node['zoo_workstation']['libreoffice_packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
