# configures chef-client when using Chef Server

unless node['zoo_workstation']['chef']['server_uri'].empty?
  cron 'chef-client' do
    user 'root'
    command '/usr/bin/chef-client'
    time :hourly
    action :create
    only_if { File.exist?('/usr/bin/chef-client') }
  end

  directory '/etc/chef' do
    owner 'root'
    group 'root'
    mode '0750'
    action :create
  end
end
