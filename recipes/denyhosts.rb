### installs and configures denyhosts

package 'denyhosts' do
  action :install
end

service 'denyhosts' do
  supports :restart => true
  action [ :enable, :start ]
end

cookbook_file '/etc/denyhosts.conf' do
  source 'denyhosts.conf'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
  notifies :restart, 'service[denyhosts]', :delayed
end

template '/var/lib/denyhosts/allowed-hosts' do
  source 'denyhosts_allowed.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[denyhosts]', :delayed
end
