Changelog
=========

2.0.0 - August 2017
-------------------

- upgrade to [Fedora 26](https://fedoraproject.org/wiki/Releases/26/ChangeSet) from Fedora 24

  - GCC 7.1 from GCC 6.3

  - Glasgow Haskell Compiler 8.0 from GHC 7.8.4

  - Python 3.6 from Python 3.5

- inclusion of the [Jupyter Notebook](https://jupyter.readthedocs.io/en/latest/content-quickstart.html)

- inclusion of the [Anaconda package manager](https://conda.io/docs/intro.html) for Python

- Chromium web browser is included in the Fedora repositories now, and supersedes proprietary Google Chrome in the default configuration

- Firefox and Chromium now ship with a default user profile, blocking web trackers out of the box

- workstations now maintain a local DNS cache, to provide marginal resiliency in the event of campus network issues

- inclusion of the [firejail](https://firejail.wordpress.com/) sandboxing mechanism (not used anywhere by default, but available)

- GNOME users now have a traditional applications launcher menu and Accessibility options (improved ADA compliance) enabled out of the box

- inclusion of [golang](https://golang.org/)

- Message of the Day now indicates a machine-specific reboot schedule, if defined

- users can now change their network password using the `passwd` command, if connected to a Kerberos domain

- inclusion of robotics software, curated by the [Fedora Robotics Lab](https://labs.fedoraproject.org/en/robotics/)

- inclusion of security research software, curated by the [Fedora Security Lab](https://labs.fedoraproject.org/en/security/)

- inclusion of audio editing software and the Jackd audio server

- inclusion of [SuperCollider](https://supercollider.github.io/)

- inclusion of [Zotero](https://www.zotero.org/)

- added the [PGI GPU-aware C/C++/Fortran compilers](http://www.pgroup.com/products/community.htm), community edition

- new command: `force_quit_all_on_host` will quit all active processes under the current user (will force log-out the user)

- graphical users are correctly notified of pending reboot; previously alert was limited to console/ssh users

- optional remote syslog with rsyslog or Filebeat

- support for [Duo Security 2FA](https://duo.com/docs/duounix) for SSH (this is not a product endorsement)

- deprecation: python2-spacy requires python2-ffty, which has discontinued support of python2

- reminder that [python2 reaches End Of Life in 2020](https://pythonclock.org/)
