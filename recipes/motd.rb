### sets MOTD

# initialize variable
patch_cycle=nil

# fetch schedule from attributes or databag
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

    # recalculate hour,minute based on REBOOT_DELAY (the grace period for users to log out)
    hour_tmp=server['hour']
    minute_tmp=server['minute']
    unless node['zoo_workstation']['patching']['reboot_delay'].nil? || ! node['zoo_workstation']['patching']['reboot_delay'].to_i
      reboot_delay = node['zoo_workstation']['patching']['reboot_delay'].to_i
    else
      # define a default reboot_delay of 5 minutes as courtesy to users
      reboot_delay = 5
    end
    if (reboot_delay <= 5)
      # lockout_delay = 0
      hour = hour_tmp
      minute = minute_tmp
    else
      # per `man shutdown`, login is disabled within five minutes of shutdown
      # ... in MOTD we advertise the lockout time for new logins, not crontab entry to start the process, in case reboot_delay is lengthy
      lockout_delay = (reboot_delay - 5)
      hour = %x(date --date="#{hour_tmp}:#{minute_tmp} #{lockout_delay} minutes" +%H).chomp!
      minute = %x(date --date="#{hour_tmp}:#{minute_tmp} #{lockout_delay} minutes" +%M).chomp!
    end

    # convert numerical day of week to human-readable day of week
    if server['weekday'].length == 1
      days_of_the_week = {
        '*' => 'daily',
        '0' => 'Sundays',
        '1' => 'Mondays',
        '2' => 'Tuesdays',
        '3' => 'Wednesdays',
        '4' => 'Thursdays',
        '5' => 'Fridays',
        '6' => 'Saturdays',
        '7' => 'Sundays'
      }
      weekday=days_of_the_week[server['weekday']]
    else
      weekday=server['weekday']
    end
    # best-effort interpretation of monthly patch schedules
    week=''
    if server['day'] == '1-7'
      week='Monthly, first week'
    elif server['day'] == '8-14'
      week='Monthly, second week'
    elif server['day'] == '15-21'
      week='Monthly, third week'
    elif server['day'] == '22-28'
      week='Monthly, fourth week'
    end
    unless week.empty?
      patch_cycle="#{week} #{weekday}, #{hour}:#{minute}"
    else
      patch_cycle="#{weekday}, #{hour}:#{minute}"
    end
    # else rescue / don't fail
  end rescue NoMethodError
end

if patch_cycle.nil?
  # don't try to pass a nil variable to template
  patch_cycle=''
end

template '/etc/motd' do
  source 'motd.erb'
  owner 'root'
  group 'root'
  mode '0444'
  variables(
    reboot_cycle: patch_cycle
  )
  action :create
end
