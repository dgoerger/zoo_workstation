### configures firewalld

package 'firewalld' do
  action :install
end

service 'firewalld' do
  # use restart instead of reload
  # NB: 'reload' will kill the NIC when creating/destroying firewall XML files
  # ... 'restart' does not have this limitation
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template '/etc/firewalld/firewalld.conf' do
  source 'firewalld.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[firewalld]', :delayed
end

template '/etc/firewalld/zones/dmz.xml' do
  source 'firewalld_dmz.xml.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[firewalld]', :delayed
  only_if { node['zoo_workstation']['firewalld']['default_zone'] == 'dmz' }
end

template '/etc/firewalld/zones/trusted.xml' do
  # set trusted zone - ALL INBOUND CONNECTIONS ACCEPTED
  source 'firewalld_trusted.xml.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[firewalld]', :delayed
end

file '/usr/lib/firewalld/zones/FedoraServer.xml' do
  # see rhbz#1171114
  action :delete
  notifies :restart, 'service[firewalld]', :delayed
end
