### installs and configures Ruby

package 'ruby-devel' do
  action :install
end

package 'ruby-irb' do
  action :install
end

package 'rubygem-nokogiri' do
  # specifically requested by a student
  action :install
end
