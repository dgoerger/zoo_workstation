### installs and configures a Professional Audio Workstation

unless node['zoo_workstation']['audio_editing']['packages'].empty?
  node['zoo_workstation']['audio_editing']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end

include_recipe 'zoo_workstation::jackd'
