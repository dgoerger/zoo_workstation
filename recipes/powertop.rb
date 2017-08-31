### installs and configures powertop
# NB: you probably don't want to enable this if you have USB peripherals that could get powered off

package 'powertop' do
  action :install
end

service 'powertop' do
  action :disable
end
