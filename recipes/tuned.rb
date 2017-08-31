### installs and configures tuned

package 'tuned' do
  action :install
end

service 'tuned' do
  supports :restart => true
  action [ :enable, :start ]
end

template '/etc/tuned/active_profile' do
  # this appears to cut down on valgrind times by ~20%
  source 'tuned_profile.erb'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
  notifies :restart, 'service[tuned]', :delayed
end
