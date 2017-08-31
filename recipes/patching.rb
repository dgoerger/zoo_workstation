### configures a system-level patching schedule

cookbook_file '/usr/local/sbin/dnf-patch-everything' do
  # patch script for everything (including Nvidia and Chef)
  source 'dnf-patch-everything.sh'
  owner 'root'
  group 'root'
  mode '0551'
  action :create
  verify '/usr/bin/bash -n %{path}'
end

template '/usr/local/sbin/scheduled-patch' do
  # logic for handling no-change windows
  source 'patching_schedule.sh.erb'
  owner 'root'
  group 'root'
  mode '0554'
  action :create
  verify '/usr/bin/bash -n %{path}'
end

template '/usr/local/sbin/scheduled-reboot' do
  # stand-alone script for system reboots
  source 'reboot.sh.erb'
  owner 'root'
  group 'root'
  mode '0554'
  action :create
  verify '/usr/bin/bash -n %{path}'
end

if node['zoo_workstation']['patching']['auto']
  unless node['zoo_workstation']['patching']['schedules'].empty?
    # if attributes method, use that
    host=node['fqdn']
    if node['zoo_workstation']['patching']['schedules'].key?(host)
      server=node['zoo_workstation']['patching']['schedules'][host]
    end
  else
    # else try databag method
    server=search("updates", "id:#{node['fqdn']}").first
  end
  if server['day'] && server['weekday'] && server['hour'] && server['minute']
    # ^ if an updates databag entry exists for this host, and a cron minute value is defined, set patching cron
    cron 'automatic patch/reboot' do
      user 'root'
      command '/usr/local/sbin/scheduled-patch'
      day server['day']
      weekday server['weekday']
      hour server['hour']
      minute server['minute']
      action :create
    end
    # else rescue / don't fail
  else
    # if a patch schedule isn't defined for this host but a cron exists, delete it
    cron 'automatic patch/reboot' do
      user 'root'
      action :delete
    end
  end rescue NoMethodError
else
  # if a patch schedule isn't defined for this host but a cron exists, delete it
  cron 'automatic patch/reboot' do
    user 'root'
    action :delete
  end
end
