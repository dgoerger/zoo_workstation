### configures GNOME Display Manager and system-wide dconf prefs

execute 'runlevel_5' do
  command 'systemctl set-default graphical.target'
  action :nothing
end

package 'gdm' do
  action :install
  notifies :run, 'execute[runlevel_5]', :delayed
end

service 'gdm' do
  action :enable
end

package 'xorg-x11-drv-libinput' do
  action :install
end

package 'fedora-workstation-backgrounds' do
  action :install
end

package 'fedora-release-workstation' do
  action :install
end

execute 'reload_dconf' do
  command 'dconf update'
  action :nothing
end

## graphical /etc configs
directory '/etc/dconf/db/gdm.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/dconf/profile/gdm' do
  # enable management of the GDM login screen
  source 'dconf_gdm_profile'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :run, 'execute[reload_dconf]', :delayed
end

cookbook_file '/etc/dconf/db/gdm.d/00_site_settings' do
  # set GDM login screen configs
  source 'dconf_gdm_settings'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :run, 'execute[reload_dconf]', :delayed
end

directory '/etc/dconf/db/site.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/dconf/profile/user' do
  # enable management of the userland
  source 'dconf_site_profile'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :run, 'execute[reload_dconf]', :delayed
end

cookbook_file '/etc/dconf/db/site.d/00_site_settings' do
  # set some useful defaults in dconf userland
  source 'dconf_site_settings'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :run, 'execute[reload_dconf]', :delayed
end
