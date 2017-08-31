### installs and configures sagemath

package 'sagemath' do
  action :install
end

# rhbz#1464520
package 'python2-traitlets' do
  action :install
end
package 'python2-backports-shutil_get_terminal_size' do
  action :install
end
package 'python2-simplegeneric' do
  action :install
end
package 'python2-psutil' do
  action :install
end
link '/usr/lib64/libSingular.so' do
  link_type :symbolic
  to '/usr/lib64/libSingular-4.1.0.so'
  not_if { File.exist?('/usr/lib64/libSingular.so') }
end

include_recipe 'zoo_workstation::desktop_cleanup'
