# enable DKMS for automatic kernel/module rebuild

package 'dkms' do
  action :install
end

service 'dkms' do
  action [ :enable, :start ]
end
