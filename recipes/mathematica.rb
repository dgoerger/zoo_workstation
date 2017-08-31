### installs and configures Mathematica - tested 21 July 2017 against version 11.1.1

execute 'install_mathematica' do
  command 'sh /usr/local/src/mathematica.sh --nox11 -- -silent -targetdir=/usr/local/mathematica'
  action :nothing
end

remote_file '/usr/local/src/mathematica.sh' do
  source node['zoo_workstation']['mathematica']['pkg_url']
  owner 'root'
  group 'root'
  mode '0550'
  checksum node['zoo_workstation']['mathematica']['sha256']
  action :create_if_missing
  not_if { File.exist?('/usr/local/src/mathematica.sh') }
  notifies :run, 'execute[install_mathematica]', :immediately
end

directory '/usr/share/Mathematica/Licensing' do
  # after the installer completes
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/usr/share/Mathematica/Licensing/mathpass' do
  # point to the Mathematica licence server
  source 'mathematica_licence.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
