#!/bin/bash

#empty the ipreport.txt
: > ipreport.txt
# must put the ips in ip.txt text file
if [ "$1" == "ip.txt" ]
then

  # shellcheck disable=SC1073
  while read ip;
  do
    #check if ip is valid
    if [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]
    then
      #chaeck if is up
      check=$(fping "$ip")
      if grep -q "${alive}" <<< "$check"
      then
        echo "$ip is UP."
        echo "$ip is UP." >> ipreport.txt
      else
        echo "$ip is OFFLINE."
        echo "$ip is OFFLINE." >> ipreport.txt
      fi
    else
      # in case is invalid
      echo "$ip is invalid"
      echo "$ip is invalid" >> ipreport.txt
    fi
  done < $1;
else
    echo "type bash ipcheck.sh {the ips in the ip.txt file}"
fi