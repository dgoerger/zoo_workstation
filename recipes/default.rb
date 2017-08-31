# Cookbook Name:: zoo_workstation
# Recipe:: default

### software installation
## Free and Open Source Software
include_recipe 'zoo_workstation::atom'
include_recipe 'zoo_workstation::audio_editing'
include_recipe 'zoo_workstation::browsers'
include_recipe 'zoo_workstation::c'
include_recipe 'zoo_workstation::coq'
include_recipe 'zoo_workstation::cups' unless node['zoo_workstation']['cups_server'].empty?
include_recipe 'zoo_workstation::database'
include_recipe 'zoo_workstation::debuginfo'
include_recipe 'zoo_workstation::denyhosts'
include_recipe 'zoo_workstation::devel'
include_recipe 'zoo_workstation::dns'
include_recipe 'zoo_workstation::eclipse'
include_recipe 'zoo_workstation::emacs'
include_recipe 'zoo_workstation::erlang'
include_recipe 'zoo_workstation::firejail'
include_recipe 'zoo_workstation::firewalld'
include_recipe 'zoo_workstation::fun'
include_recipe 'zoo_workstation::gdm'
include_recipe 'zoo_workstation::git'
include_recipe 'zoo_workstation::gnome'
include_recipe 'zoo_workstation::go'
include_recipe 'zoo_workstation::haskell'
include_recipe 'zoo_workstation::image_editing'
include_recipe 'zoo_workstation::java'
include_recipe 'zoo_workstation::julia'
include_recipe 'zoo_workstation::libreoffice'
include_recipe 'zoo_workstation::libvirt'
include_recipe 'zoo_workstation::lisp'
include_recipe 'zoo_workstation::mate'
include_recipe 'zoo_workstation::modelling'
include_recipe 'zoo_workstation::motd'
include_recipe 'zoo_workstation::msmtp' unless node['zoo_workstation']['msmtp']['smarthost'].empty? || node['zoo_workstation']['msmtp']['port'].empty? || node['zoo_workstation']['msmtp']['domain'].empty?
include_recipe 'zoo_workstation::nfs' unless node['zoo_workstation']['nfs_mounts'].empty?
include_recipe 'zoo_workstation::nrpe' unless node['zoo_workstation']['nrpe']['allowed_hosts'].empty?
include_recipe 'zoo_workstation::octave'
include_recipe 'zoo_workstation::openbox'
include_recipe 'zoo_workstation::openssh'
include_recipe 'zoo_workstation::passwd' unless node['zoo_workstation']['sssd']['kerberos_server'].empty?
include_recipe 'zoo_workstation::perl'
include_recipe 'zoo_workstation::polkit'
include_recipe 'zoo_workstation::powertop'
include_recipe 'zoo_workstation::python'
include_recipe 'zoo_workstation::r'
include_recipe 'zoo_workstation::racket'
include_recipe 'zoo_workstation::robotics'
include_recipe 'zoo_workstation::rsyslog'
include_recipe 'zoo_workstation::ruby'
include_recipe 'zoo_workstation::rust'
include_recipe 'zoo_workstation::sagemath'
include_recipe 'zoo_workstation::security'
include_recipe 'zoo_workstation::sssd'
include_recipe 'zoo_workstation::shell'
include_recipe 'zoo_workstation::texlive'
include_recipe 'zoo_workstation::tuned'
include_recipe 'zoo_workstation::utils'
include_recipe 'zoo_workstation::video_editing'
include_recipe 'zoo_workstation::vim'
include_recipe 'zoo_workstation::xfce'

## proprietary software
include_recipe 'zoo_workstation::chef' # this is mostly open source but is not in the repos
include_recipe 'zoo_workstation::fastx' unless node['zoo_workstation']['fastx']['pkg_url'].empty? || node['zoo_workstation']['fastx']['server'].empty?
include_recipe 'zoo_workstation::filebeats' unless node['zoo_workstation']['filebeats']['hosts'].empty?
include_recipe 'zoo_workstation::google_chrome' if node['zoo_workstation']['google_chrome']['install']
include_recipe 'zoo_workstation::mathematica' unless node['zoo_workstation']['mathematica']['pkg_url'].empty? || node['zoo_workstation']['mathematica']['server'].empty? || node['zoo_workstation']['mathematica']['sha256'].empty?
include_recipe 'zoo_workstation::matlab' unless node['zoo_workstation']['matlab']['pkg_url'].empty? || node['zoo_workstation']['matlab']['file_installation_key'].empty? || node['zoo_workstation']['matlab']['network_lic'].empty?
include_recipe 'zoo_workstation::nvidia' if node['zoo_workstation']['nvidia']['install']


### administrativa
include_recipe 'zoo_workstation::admin_local' unless node['zoo_workstation']['admin_local']['gecos'].empty? || node['zoo_workstation']['admin_local']['username'].empty? || node['zoo_workstation']['admin_local']['privileges'].empty?
include_recipe 'zoo_workstation::patching'
include_recipe 'zoo_workstation::sudo'
include_recipe 'zoo_workstation::symlinks'
