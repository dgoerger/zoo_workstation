### installs proprietary Google Chrome web browser

execute 'install_google_chrome' do
  command 'dnf install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
  not_if { File.exist?("/usr/bin/google-chrome") }
end

cron 'patch_google_chrome' do
  time :daily
  user 'root'
  command '/usr/bin/dnf upgrade google-chrome-stable -y'
  action :create
end
