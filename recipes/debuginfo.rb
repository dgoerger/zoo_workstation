### installs debuginfo packages

execute 'enable_debuginfo' do
  command 'yum-config-manager --set-enabled fedora-debuginfo --set-enabled updates-debuginfo'
  action :nothing
end

package 'dnf-utils' do
  # install yum-config-manager
  action :install
  notifies :run, 'execute[enable_debuginfo]', :immediately
end

cookbook_file '/etc/dnf/plugins/debuginfo-install.conf' do
  # keep debuginfo packages up-to-date by default
  source 'dnf-plugin-debuginfo.conf'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

unless node['zoo_workstation']['debuginfo_packages'].empty?
  node['zoo_workstation']['debuginfo_packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
