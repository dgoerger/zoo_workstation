### installs and configures image editing software

unless node['zoo_workstation']['image_editor_packages'].empty?
  node['zoo_workstation']['image_editor_packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
