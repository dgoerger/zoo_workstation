### installs and configures JACKd audio server

unless node['zoo_workstation']['jackd']['packages'].empty?
  node['zoo_workstation']['jackd']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

cookbook_file '/etc/security/limits.conf' do
  source 'jackd_limits.conf'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
