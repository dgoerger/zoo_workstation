### configures sudoers

template '/etc/sudoers' do
  source 'sudoers.erb'
  owner 'root'
  group 'root'
  mode '0440'
  verify '/usr/sbin/visudo --check --quiet -f %{path}'
  action :create
end
