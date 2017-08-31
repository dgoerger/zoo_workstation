### installs and configures FastX 2

execute 'install_fastx' do
  # FastX installation
  # download newer: https://www.starnet.com/fastx/download?license_key=<licence-key>
  # the bundled libGL.so.1 segfaults on current glibc
  command "dnf install -y /usr/local/src/fastx.rpm && ln -sf /usr/lib64/libGL.so.1 /usr/lib/fastx2/xrdp/lib64/libGL.so.1"
  action :nothing
end

remote_file '/usr/local/src/fastx.rpm' do
  source node['zoo_workstation']['fastx']['pkg_url']
  owner 'root'
  group 'root'
  mode '0440'
  checksum node['zoo_workstation']['fastx']['sha256']
  action :create_if_missing
  not_if { File.exist?('/usr/local/src/fastx.rpm') }
  notifies :run, 'execute[install_fastx]', :immediately
end

directory '/usr/lib/fastx2/var/license' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/usr/lib/fastx2/var/license/#{node['zoo_workstation']['fastx']['server']}.lic" do
  source 'fastx_licence_server.lic.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

cookbook_file '/usr/lib/fastx2/config/suggestions.json' do
  # define what desktops are available for use
  # NOTE: with the proprietary Nvidia driver installed, OpenGL desktops like GNOME and KDE *do not work*
  source 'fastx_available_desktops.json'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  only_if { File.exist?("/usr/lib/fastx2/config") }
end
