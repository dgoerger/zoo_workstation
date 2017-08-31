### disables SELinux

cookbook_file '/etc/selinux/config' do
  # disable selinux, interferes with MatLab and Mathematica
  # takes effect on next boot
  source 'selinux_config'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
