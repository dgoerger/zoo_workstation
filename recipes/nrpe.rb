### installs and configures NRPE

package 'nrpe' do
  action :install
end

package 'nagios-plugins-all' do
  action :install
end

package 'nagios-plugins-uptime' do
  action :install
end

directory '/usr/local/lib64/nagios' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/lib64/nagios/check_autofs' do
  source 'nrpe_check_autofs.sh'
  owner 'root'
  group 'root'
  mode '0445'
  action :create
end

template '/usr/local/lib64/nagios/check_ldaps_zoo' do
  source 'nrpe_check_ldaps_zoo.sh.erb'
  owner 'root'
  group 'root'
  mode '0445'
  action :create
end

cookbook_file '/usr/local/lib64/nagios/check_memory' do
  source 'nrpe_check_memory.sh'
  owner 'root'
  group 'root'
  mode '0445'
  action :create
end

cookbook_file '/usr/local/lib64/nagios/check_readonly_fs' do
  source 'nrpe_check_readonly_fs.sh'
  owner 'root'
  group 'root'
  mode '0445'
  action :create
end

service 'nrpe' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

template '/etc/nagios/nrpe.cfg' do
  source 'nrpe.cfg.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[nrpe]', :delayed
end
