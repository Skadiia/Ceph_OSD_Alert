#!/bin/bash

for osd in $(ls /var/lib/ceph/osd/)
do
  use=$(df -h /var/lib/ceph/osd/$osd|awk -v ligne=2 ' NR == ligne { print $5 }'|sed -e 's/.$//')
  if [[ $use -gt 85 ]]
    then
      if [[ $use -gt 95 ]]
       then
         echo "ALERT: $osd Full at $use%"|mail -s "ALERT: $osd Full" < mail@address >
       else
         echo "ALERT: $osd NearFull at $use%"|mail -s "ALERT: $osd NearFull" < mail@address>
      fi
  fi
done
