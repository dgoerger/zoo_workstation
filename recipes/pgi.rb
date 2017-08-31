### installs and configures PGI compilers (leverages NVidia GPUs)

execute 'install_pgi' do
  command 'PGI_SILENT=true PGI_ACCEPT_EULA=accept PGI_INSTALL_NVIDIA=true PGI_INSTALL_MPI=true PGI_MPI_GPU_SUPPORT=true sh /var/tmp/pgi/install'
  action :nothing
  only_if { File.exist?('/var/tmp/pgi/install') && ! File.exist?('/opt/pgi') }
end

execute 'extract_pgi_installer' do
  command 'mkdir -p /var/tmp/pgi && tar -xf /var/tmp/pgi.tar.gz -C /var/tmp/pgi'
  action :nothing
  notifies :run, 'execute[install_pgi]', :immediately
  not_if { File.exist?('/opt/pgi') }
end

remote_file '/var/tmp/pgi.tar.gz' do
  source node['zoo_workstation']['pgi']['pkg_url']
  owner 'root'
  group 'root'
  mode '0444'
  checksum node['zoo_workstation']['pgi']['sha256']
  action :create
  not_if { File.exist?('/opt/pgi') }
  notifies :run, 'execute[extract_pgi_installer]', :immediately
end

file '/opt/pgi/license.dat' do
  mode '0444'
  action :create
  only_if { File.exist?('/opt/pgi') }
end

cookbook_file '/etc/profile.d/pgi.sh' do
  source 'bash_pgi.sh'
  owner 'root'
  group 'root'
  mode '0555'
  action :create
end
