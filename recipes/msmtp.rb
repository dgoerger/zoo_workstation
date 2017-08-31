### installs and configures msmtp

package 'msmtp' do
  action :install
end

package 'mailx' do
  action :install
end

template '/etc/msmtprc' do
  source 'msmtprc.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

cookbook_file '/etc/mail.rc' do
  source 'mail.rc'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
