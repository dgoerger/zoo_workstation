### miscellaneous cleanup

directory '/usr/local/share/applications' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

unless node['zoo_workstation']['desktop_cleanup'].empty?
  # remove extraneous .desktop files - apps are still installed, simply remove from application launch menu
  node['zoo_workstation']['desktop_cleanup'].each do |app|
    cookbook_file "/usr/local/share/applications/#{app}.desktop" do
      source 'desktop_app_hide.desktop'
      owner 'root'
      group 'root'
      mode '0444'
      action :create
    end
  end
end
