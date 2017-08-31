### installs and configures commons shells

unless node['zoo_workstation']['shell']['packages'].empty?
  node['zoo_workstation']['shell']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

template '/etc/profile.d/zoo_aliases.sh' do
  # custom but useful global aliases loaded with /etc/bashrc
  source 'bash_aliases.sh.erb'
  owner 'root'
  group 'root'
  mode '0555'
  action :create
end

# set this up so it copies ~/.ssh for new users, with the correct permissions
directory '/etc/skel/.ssh' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

file '/etc/skel/.ssh/authorized_keys' do
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end
