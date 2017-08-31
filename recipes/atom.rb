### installs the Atom.io editor

execute 'enable_atom' do
  # enable COPR for the Atom text editor / IDE
  command 'dnf copr enable mosquito/atom -y'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/_copr_mosquito-atom.repo') }
end

package 'atom' do
  action :install
end
