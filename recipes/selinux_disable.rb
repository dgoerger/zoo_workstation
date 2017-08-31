### disables SELinux

cookbook_file '/etc/selinux/config' do
  source 'selinux_config'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
