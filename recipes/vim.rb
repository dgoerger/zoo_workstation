### installs and configures Vim and Neovim

# Nvi
package 'nvi' do
  # the bug-for-bug compatible 4.4BSD reimplementation of vi
  action :install
end

# Vim
package 'vim-enhanced' do
  action :install
end
package 'vim-X11' do
  # gui vim
  action :install
end
unless node['zoo_workstation']['vim']['plugins'].empty?
  # all the plugins
  node['zoo_workstation']['vim']['plugins'].each do |pkg|
    package pkg do
      action :install
    end
  end
end
cookbook_file '/etc/vimrc' do
  # better global - permits site-specific conf
  source 'vimrc'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end
cookbook_file '/etc/vimrc.local' do
  # site-specific conf
  source 'vimrc.local'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

# Neovim
package 'neovim' do
  action :install
end
