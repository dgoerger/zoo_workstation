### installs and configures the NVIDIA proprietary driver, CUDA, etc

# enable additional repos
include_recipe 'zoo_workstation::rpmfusion'
include_recipe 'zoo_workstation::zoo_repo'
include_recipe 'zoo_workstation::dkms'
execute 'enable_NVIDIA' do
  # enable Negativo17's NVIDIA repo for CUDA et al - REQUIRES RPMFUSION
  command 'dnf config-manager --add-repo=https://negativo17.org/repos/fedora-nvidia.repo'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/fedora-nvidia.repo') }
end

# install NVIDIA driver
node['zoo_workstation']['nvidia']['packages'].each do |pkg|
  dnf_package pkg do
    action :install
  end
end

# configure NVIDIA driver
execute 'configure_nvidia' do
  command 'nvidia-xconfig && dkms autoinstall'
  action :run
  only_if { File.exist?('/usr/lib64/nvidia/xorg') && ! File.exist?('/etc/X11/xorg.conf') }
end

cookbook_file '/etc/modprobe.d/nvidia-installer-disable-nouveau.conf' do
  # block the nouveau driver here too
  source 'nvidia-installer-disable-nouveau.conf'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

include_recipe 'zoo_workstation::selinux_disable'
include_recipe 'zoo_workstation::pgi'
