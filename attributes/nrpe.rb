# pidfile should be in a folder owned by nrpe user so that the init script can delete the old pidfile
default['zoo_workstation']['nrpe']['pidfile'] = '/var/run/nrpe/nrpe.pid'
# restrict access to execute nrpe checks to open port 5666 - keep this locked down to the minimum required IPs
default['zoo_workstation']['nrpe']['allowed_hosts'] = '127.0.0.1'
# define some useful checks by default
default['zoo_workstation']['nrpe']['checks'] = {
  # ensure all defined automounts are mounted
  'check_autofs' => '/usr/local/lib64/nagios/check_autofs',
  # check usage on local disks
  'check_disk' => '/usr/lib64/nagios/plugins/check_disk -w 30% -c 5% -N ext4 -N xfs',
  # check usage on network volumes
  'check_disk_nas' => '/usr/lib64/nagios/plugins/check_disk -w 15% -c 5% -N nfs -N cifs',
  # check ldaps connectivity
  'check_ldaps_zoo' => '/usr/local/lib64/nagios/check_ldaps_zoo',
  # check system load - by default log it but don't alert (load is expected to be high on compute nodes)
  'check_load' => '/usr/lib64/nagios/plugins/check_load -r -w 1000,1000,1000 -c 1000,1000,1000',
  # check memory utilization
  'check_memory' => '/usr/local/lib64/nagios/check_memory -w 90 -c 100',
  # calculate system time drift
  'check_ntp_time' => '/usr/lib64/nagios/plugins/check_ntp_time -H 0.fedora.pool.ntp.org -w 0.5 -c 1.5',
  # check procs (accepts arguments)
  'check_procs_generic' => '/usr/local/nagios/libexec/check_procs -w $ARG1$ -c $ARG2$ -a $ARG3$ -u $ARG4$',
  # are any filesystems flagged readonly?
  'check_readonly_fs' => '/usr/local/lib64/nagios/check_readonly_fs',
  # check swap usage
  'check_swap' => '/usr/lib64/nagios/plugins/check_swap -w 30% -c 10%',
  # if we haven't rebooted in a while, warn but don't crit
  'check_uptime' => '/usr/lib64/nagios/plugins/check_uptime -u days -w 60',
  # is X11 running?
  'check_procs_x11' => '/usr/lib64/nagios/plugins/check_procs -w 1: -c 1: -a /usr/libexec/Xorg'
}
