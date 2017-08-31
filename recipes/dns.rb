### installs and configures dnsmasq

package 'dnsmasq' do
  action :install
end

service 'NetworkManager' do
  supports :reload => true
  action :nothing
end

template '/etc/NetworkManager/NetworkManager.conf' do
  source 'NetworkManager.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :reload, 'service[NetworkManager]', :delayed
end

# dnsblock - blackhole bad stuff
execute 'dnsblock_initialize' do
  command '/usr/local/bin/dnsblock_updater'
  action :nothing
end

cookbook_file '/usr/local/bin/dnsblock_updater' do
  source 'dnsblock_updater'
  owner 'root'
  group 'root'
  mode '0554'
  action :create
  notifies :run, 'execute[dnsblock_initialize]', :delayed
end

cron 'dnsblock_update' do
  time :weekly
  user 'root'
  command '/usr/local/sbin/dnsblock_updater'
  action :create
end
