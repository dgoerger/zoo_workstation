#!/bin/bash

# ensure we pull the latest packages
/usr/bin/dnf clean metadata
/usr/bin/dnf upgrade -y

# restore libglx... TODO find more elegant solution
if [[ -f /usr/lib64/nvidia/xorg/libglx.so ]] && [[ -f /usr/lib64/xorg/modules/extensions/libglx.so ]]; then
  /usr/bin/ln -sf /usr/lib64/nvidia/xorg/libglx.so /usr/lib64/xorg/modules/extensions/libglx.so
fi

# chef - if installed
if /usr/bin/dnf list installed chef >/dev/null 2>&1; then
  chef_url=$(/usr/bin/curl 'https://omnitruck.chef.io/stable/chef/metadata?v=13&p=el&pv=7&m=x86_64' 2>/dev/null | /usr/bin/grep "^url" | /usr/bin/awk -F" " '{print $2}' | /usr/bin/grep -E "^https://.*\.el7\.x86_64\.rpm$")
  if [[ -n ${chef_url} ]]; then
    /usr/bin/dnf upgrade -y ${chef_url}
  fi
fi

# chefdk - if installed
if /usr/bin/dnf list installed chefdk >/dev/null 2>&1; then
  chefdk_url=$(/usr/bin/curl -L "https://downloads.chef.io/chefdk/stable" 2>/dev/null | /usr/bin/sed 's/href/\n/g' | /usr/bin/grep -E "=\"https\:.*.el7.x86_64.rpm" | /usr/bin/awk -F'"' '{print $2}' | /usr/bin/sed 's/\&\#x2F\;/\//g' | /usr/bin/grep -E "^https://.*\.el7\.x86_64\.rpm$")
  if [[ -n ${chefdk_url} ]]; then
    /usr/bin/dnf upgrade -y ${chefdk_url}
  fi
fi

# reboot
/usr/local/sbin/scheduled-reboot
