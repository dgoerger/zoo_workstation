### installs and configures GNU Octave

unless node['zoo_workstation']['octave']['packages'].empty?
  node['zoo_workstation']['octave']['packages'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
