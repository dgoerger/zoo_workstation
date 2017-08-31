### installs Zoo-specific packages

execute 'enable_yale-zoo' do
  # enable COPR for Yale Zoo (Yale-maintained RPMs)
  command 'dnf copr enable dgoerger/yale-zoo -y'
  action :run
  not_if { File.exist?('/etc/yum.repos.d/_copr_dgoerger-yale-zoo.repo') }
end
