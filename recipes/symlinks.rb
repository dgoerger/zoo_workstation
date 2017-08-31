### creates system-level symlinks

unless node['zoo_workstation']['symlinks'].empty?
  node['zoo_workstation']['symlinks'].each do |link,target|
    link "#{link}" do
      to target
      link_type :symbolic
      action :create
    end
  end
end
