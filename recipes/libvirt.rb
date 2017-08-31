### installs and configures libvirt

package 'libvirt-devel' do
  action :install
end

package 'libvirt-daemon-qemu' do
  action :install
end

service 'libvirtd' do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end
