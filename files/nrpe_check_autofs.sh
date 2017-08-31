#!/bin/bash

CHECK=AUTOFS

# function for doing the check and setting $INFO
function check()
{
LOG=""
IFS="
"
for mapline in $(cat /etc/auto.master | grep -Ev "^\#" | grep -Ev "^$"); do
  map=$(echo ${mapline} | awk '{print $2}')
  if [[ "$(echo ${mapline} | awk '{print $1}')" == "/-" ]]; then
    # direct mounts mount directly
    autoroot="/"
  else
    autoroot=$(echo ${mapline} | awk '{print $1}')
  fi
  # skip if the map doesn't exist
  if [[ ! -f ${map} ]]; then
    #echo "$map doesn't exist"
    continue
  fi
  # determine root for this map
  for mountpoint in $(awk '{print $1}' ${map} | grep -Ev "^\#" | grep -Ev "^$"); do
    ls ${autoroot}/${mountpoint} >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      FLATERR=$(echo -n "$LOG ${autoroot}/${mountpoint}")
      MAPLINE="NOT OK $(grep ${mountpoint} ${map})"
      ERROR=$(echo "${ERROR}\n${MAPLINE}")
    else
      /bin/true
      MAPLINE="OK $(grep ${mountpoint} ${map})"
      INFO=$(echo "${INFO}\n${MAPLINE}")
    fi
  done
done

if [[ "${FLATERR}" == "" ]]; then
  INFO="All defined automounts are OK."
  return 0
else
  return 1
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
  echo -n "${CHECK} ${STATUS} - ${INFO}"
else
  echo -n "${CHECK} ${STATUS} - can't read: ${FLATERR}"
fi

exit "${RC}"
