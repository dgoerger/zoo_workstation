#!/bin/bash

CHECK=MEMORY

while getopts ":w:c:" o; do
  case "${o}" in
    w)
      warning=${OPTARG}
      ;;
    c)
      critical=${OPTARG}
      ;;
   esac
done

if [[ -z "${warning}" ]] || [[ -z "${critical}" ]]; then
  echo -n "Too few arguments."
  exit 1
fi

# function for doing the check and setting $INFO
function check()
{
  IFS=$'\n'

  query=$(free -b | grep -E "^Mem:" | awk '{ print $2,$3,$7 }')
  percent_used=$(echo ${query} | awk '{print $2/$1*100}')
  percent_free=$(echo ${query} | awk '{print $3/$1*100}')
  total=$(echo ${query} | awk '{print $1/1024^2}')
  used=$(echo ${query} | awk '{print $2/1024^2}')
  available=$(echo ${query} | awk '{print $3/1024^2}')
  if (( $(bc <<< "${percent_used} >= ${critical}") )); then
    STATUS=CRITICAL
  elif (( $(bc <<< "${percent_used} >= ${warning}") )); then
    STATUS=WARNING
  else
    STATUS=OK
  fi
  if [[ "${STATUS}" != "OK" ]]; then
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

# NAGIOS plugin output
echo -n "${CHECK} - ${STATUS}: ${percent_used}% used (${used}/${total} MiB) | utilization=${percent_used}"

exit "${RC}"
