### installs and configures git, subversion

## git
package 'git-all' do
  action :install
end

package 'git-cal' do
  action :install
end

package 'git-merge-changelog' do
  action :install
end

package 'git-tools' do
  action :install
end

package 'git2cl' do
  action :install
end

package 'tig' do
  action :install
end

cookbook_file '/etc/gitconfig' do
  source 'gitconfig'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

## subversion
package 'subversion' do
  action :install
end

cookbook_file '/etc/subversion/config' do
  source 'subversion_config'
  owner 'root'
  group 'root'
  mode '0444'
  action :create
end

## others
package 'cvs' do
  action :install
end

package 'rcs' do
  action :install
end

## misc tools
package 'colordiff' do
  action :install
end

package 'diffstat' do
  action :install
end

package 'diffutils' do
  action :install
end

package 'meld' do
  action :install
end

package 'patch' do
  action :install
end

package 'patchutils' do
  action :install
end
