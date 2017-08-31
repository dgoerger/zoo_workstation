#!/bin/bash

CHECK=READONLYFS

# function for doing the check and setting $INFO
function check()
{
  IFS=$'\n'

  ro_found=0
  ro_filesystems=$(cat /proc/mounts | grep -E "ext(3|4)|xfs" | awk -v OFS=' ' '{print $1 "," $4}' | awk -F ',' '$2 == "ro" {print $1 " " $2}')
  message=""
  for mountpoint in ${ro_filesystems}; do
    message+=${mountpoint}
    message+=", "
    ro_found=$((ro_found+1))
  done
  if [[ ${ro_found} -gt 0 ]]; then
    return 1
  else
    return 0
  fi
}

# default to OK
RC=0; STATUS=OK

# do the check & report to bbdisplay
check
RC=$?

if [[ "${RC}" -eq 1 ]]; then
  RC=2; STATUS=Critical
fi

# NAGIOS plugin output
if [[ ${RC} -eq 0 ]]; then
  echo -n "${CHECK} - ${STATUS}"
else
  echo -n "${CHECK} - ${STATUS} - read-only filesystems found: ${message}"
fi

exit "${RC}"
