### installs and configures openbox desktop environment

package 'openbox' do
  action :install
end

package 'obconf' do
  # conf editor
  action :install
end
