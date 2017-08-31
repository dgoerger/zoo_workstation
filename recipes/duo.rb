### installs and configures DUO

execute 'import_duo_gpg' do
  command 'rpm --import https://duo.com/RPM-GPG-KEY-DUO'
  action :nothing
end

cookbook_file '/etc/yum.repos.d/duosecurity.repo' do
  source 'duosecurity.repo'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :run, 'execute[import_duo_gpg]', :immediately
end

package 'duo_unix' do
  action :install
end

template '/etc/duo/pam_duo.conf' do
  source 'pam_duo.conf.erb'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end
