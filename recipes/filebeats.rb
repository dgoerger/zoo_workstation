### installs and configures Filebeat, an ElasticSearch log-shipping daemon

cookbook_file '/etc/yum.repos.d/elastic.repo' do
  source 'elastic.repo'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

package 'filebeat' do
  action :install
end

service 'filebeat' do
  supports :restart => true
  action [ :enable, :start ]
end

directory '/etc/filebeat/conf.d/' do
  owner 'root'
  group 'root'
  recursive true
  action :create
end

template '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  owner 'root'
  group 'root'
  mode '0750'
  notifies :restart, 'service[filebeat]', :delayed
end

%w(filebeat.template.json filebeat.template-es2x.json filebeat.full.yml).each do |filename|
  file "/etc/filebeat/#{filename}" do
    action :delete
    notifies :restart, 'service[filebeat]', :delayed
  end
end
