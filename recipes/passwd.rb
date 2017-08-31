### permit users to change their password in case of central auth (kerberos)

package 'samba-common-tools' do
  action :install
end

template '/usr/local/bin/passwd' do
  source 'passwd.erb'
  owner 'root'
  group 'root'
  mode '0005'
  action :create
end
