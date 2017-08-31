# per http://www.pgroup.com/doc/pgiinstall174.pdf
# tested for version 17.4
# will need to update path for new versions

export PGI=/opt/pgi
export PATH=${PGI}/linux86-64/17.4/bin:$PATH
export MANPATH=$MANPATH:${PGI}/linux86-64/17.4/man
export LM_LICENSE_FILE=$LM_LICENSE_FILE:${PGI}/license.dat
