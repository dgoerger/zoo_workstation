### installs the firejail seccomp-bpf filter

execute 'enable_firejail' do
  # enable COPR for firejail - pending rhbz#1301286
  command ' dnf copr enable ssabchew/firejail -y'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/_copr_ssabchew-firejail.repo') }
end

package 'firejail' do
  action :install
end
