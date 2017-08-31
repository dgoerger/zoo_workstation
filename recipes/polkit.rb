### configures polkit for a shared workstation environment

cookbook_file '/etc/polkit-1/rules.d/55-inhibit-shutdown.rules' do
  # prevent mortals from rebooting the computer
  source 'polkit_55-inhibit-shutdown.rules'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

cookbook_file '/etc/polkit-1/rules.d/15-mount-usbs.rules' do
  # permit non-admins to mount USBs
  source 'polkit_15-mount-usbs.rules'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
