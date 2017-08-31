### mostly needed for NVIDIA, CUDA - try not to add unnecessary deps on this

execute 'enable_rpmfusion-free' do
  # enable RPMFusion Free repos - REQUIRED BY NVIDIA
  command 'dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-26.noarch.rpm'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/rpmfusion-free.repo') }
end
execute 'enable_rpmfusion-nonfree' do
  # enable RPMFusion Non-Free repos - REQUIRED BY NVIDIA
  command 'dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-26.noarch.rpm'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/rpmfusion-nonfree.repo') }
end

# since we're enabling RPMFUSION anyway
package 'fuse-exfat' do
  action :install
end
