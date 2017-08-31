### installs and configures OpenSSH

package 'openssh-server' do
  action :install
end

package 'mosh' do
  action :install
end

service 'sshd' do
  supports :restart => true
  action [ :enable, :start ]
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[sshd]', :delayed
  verify '/usr/sbin/sshd -t -f %{path}'
end

template '/etc/pam.d/sshd' do
  source 'duo_pam_sshd'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  # TODO: is there a verify command for PAM?
end

cron 'patch_openssh' do
  time :daily
  user 'root'
  command '/usr/bin/dnf upgrade mosh openssh -y'
  action :create
end

include_recipe 'zoo_workstation::duo' unless node['zoo_workstation']['duo']['api_host'].empty? || node['zoo_workstation']['duo']['ikey'].empty? || node['zoo_workstation']['duo']['skey'].empty?
