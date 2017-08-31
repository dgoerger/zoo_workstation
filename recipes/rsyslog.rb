# installs and configures rsyslog

package 'rsyslog' do
  action :install
end

service 'rsyslog' do
  supports :restart => true
  action [ :enable, :start ]
end

template '/etc/rsyslog.conf' do
  source 'rsyslog.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[rsyslog]', :delayed
end
