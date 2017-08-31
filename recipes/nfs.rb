### installs and configures NFS client services

package 'nfs-utils' do
  action :install
end

package 'autofs' do
  action :install
end

service 'autofs' do
  supports :status => true, :reload => true
  action [ :enable, :start ]
end

cookbook_file '/etc/auto.master' do
  source 'auto.master'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :reload, 'service[autofs]', :delayed
end

template '/etc/auto.direct' do
  # mount specific paths such as /home, /var/spool/mail
  source 'auto.direct.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :reload, 'service[autofs]', :delayed
end
