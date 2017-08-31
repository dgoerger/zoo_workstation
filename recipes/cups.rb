### installs and configures CUPS

package 'cups' do
  action :install
end

template '/etc/cups/client.conf' do
  source 'cups_client.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
