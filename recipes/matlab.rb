### installs and configures Matlab

directory '/usr/local/matlab/licenses' do
  # Matlab install and licensing directory
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/usr/local/matlab/licenses/network.lic' do
  source 'matlab_network.lic.erb'
  owner 'root'
  group 'root'
  # network.lic needs to be readable by unprivileged matlab procs
  mode '0444'
  action :create
end

### temporary install files
directory '/var/tmp/matlab_src' do
  # Matlab source directory
  owner 'root'
  group 'root'
  mode '0550'
  action :create
  not_if { File.exist?('/usr/local/matlab/bin/matlab') }
end

template '/var/tmp/matlab_installer_input.txt' do
  # Matlab installer parameters
  source 'matlab_installer_input.txt.erb'
  owner 'root'
  group 'root'
  # site activation key does NOT need to be world-readable
  mode '0440'
  action :create
  not_if { File.exist?('/usr/local/matlab/bin/matlab') }
end

execute 'install_matlab' do
  command 'sh /var/tmp/matlab_src/install -inputFile /var/tmp/matlab_installer_input.txt'
  action :nothing
  only_if { File.exist?('/var/tmp/matlab_installer_input.txt') }
end

execute 'untar_matlab_installer' do
  command 'tar -xf /var/tmp/matlab.tar.gz -C /var/tmp/matlab_src'
  action :nothing
  notifies :run, 'execute[install_matlab]', :immediately
end

remote_file '/var/tmp/matlab.tar.gz' do
  source node['zoo_workstation']['matlab']['pkg_url']
  owner 'root'
  group 'root'
  mode '0550'
  checksum node['zoo_workstation']['matlab']['sha256']
  action :create_if_missing
  not_if { File.exist?('/usr/local/matlab/bin/matlab') }
  notifies :run, 'execute[untar_matlab_installer]', :immediately
end

cookbook_file '/usr/local/matlab/matlab_desktop_icon.png' do
  # the installer doesn't include a desktop icon greater than 16x16px, fetch and cache from Interwebs
  source 'matlab.png'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

cookbook_file '/usr/local/share/applications/matlab.desktop' do
  # nor does the installer include a .desktop file, roll our own
  source 'matlab.desktop'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

link '/usr/local/bin/matlab' do
  # Matlab curiously doesn't link itself in any default path
  to '/usr/local/matlab/bin/matlab'
  link_type :symbolic
  action :create
  only_if { File.exist?('/usr/local/matlab/bin/matlab') }
end
