### installs and configures sssd

package 'sssd' do
  action :install
end

package 'pam_krb5' do
  action :install
end

execute 'rebuild_authconfig' do
  # use authconfig to manage files instead of managing the zillion configs it manipulates
  # need to explicitly enable krb5, not sure why sssd-krb5 isn't sufficient, doesn't hurt
  command 'authconfig --enablesssd --enablesssdauth --enablekrb5 --enablemkhomedir --disablecachecreds --disableldap --disableshadow --passalgo=sha512 --disablelocauthorize --enablesysnetauth --disablefingerprint --updateall && systemctl restart sssd'
  action :nothing
end

template '/etc/sssd/sssd.conf' do
  source 'sssd.conf.erb'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
  notifies :run, 'execute[rebuild_authconfig]', :delayed
  not_if { node['zoo_workstation']['sssd']['domain'].empty? || node['zoo_workstation']['sssd']['kerberos_realm'].empty? || node['zoo_workstation']['sssd']['kerberos_server'].empty? || node['zoo_workstation']['sssd']['ldap_dc'].empty? || node['zoo_workstation']['sssd']['ldap_server'].empty? }
end

template '/etc/krb5.conf' do
  source 'krb5.conf.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  not_if { node['zoo_workstation']['sssd']['kerberos_realm'].empty? || node['zoo_workstation']['sssd']['kerberos_server'].empty? }
end
