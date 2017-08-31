### installs and configures emacs

package 'emacs-nox' do
  # cli
  action :install
end

package 'emacs' do
  # gui
  action :install
end

unless node['zoo_workstation']['emacs']['plugins'].empty?
  node['zoo_workstation']['emacs']['plugins'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
