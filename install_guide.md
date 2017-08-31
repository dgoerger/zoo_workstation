Gari install procedure
======================

- download latest Network Install ISO: https://getfedora.org
- burn said ISO to a USB
- CONFIRM SYSTEM BIOS IS SET TO PREFER UEFI
- boot off USB, select "Install" (or "Test this media and Install", per preference)
- English language -> English (United States)
- confirm Time & Date timezone is correct ("Americas/New York")
- select "Network & Host Name"
- set hostname as FQDN
- Ethernet -> Configure...
  - IPv4 Settings
    - select "Method" "manual", "Add" host IP, Netmask, Gateway, DNS, select "Require IPv4 addressing for this connection to complete"
  - IPv6 Settings
    - select "Method" "ignore"
  - SAVE
  - turn Ethernet OFF then ON to reset
  - confirm it can successfully connect with the specified IP address
- select "Installation Source", "done" (need to refresh repo data now that the network works)
- select "Software Selection" -> "Minimal install"
- select "Installation Destination" -> Custom -> delete all previous partitions (WARNING!! DATA LOSS!!) -> suggested new layout
  - /boot/efi -  50MiB (if it doesn't offer /boot/efi in the dropdown, you're not booted UEFI and should change BIOS settings to prefer UEFI)
  - /boot     - 450MiB (type LVM)
  - /var      -  30GiB (since we're caching Chef artefacts there)
  - swap      - [how much RAM there is]
  - /         - [the rest]
  - NB: WARNING - CHANGE THE VOLUME GROUP NAME TO "fedora" OR SOMETHING CONSISTENT IN CASE YOU EVER HAVE TO MASS-EDIT /etc/default/grub
- BEGIN INSTALLATION
- "User Creation" -> create a local user for yourself in /var/home, set as administrator
  - use ansible or something to delete these accounts later - we need a local account to run the postinstall script
- reboot once install is finished

- rsync -av path/to/postinstall.sh ${hostname}:
- sh postinstall.sh
