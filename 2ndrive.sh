#!/bin/sh
names=( $(/usr/sbin/diskutil list | grep -o '/dev/disk.') )
for name in ${names[@]}
do
  info="$(/usr/sbin/diskutil info $name | grep '*****YOUR DRIVE'S NAME*****')"
  if [ ${#info} -ge 1 ]
  then
    echo `/usr/sbin/diskutil $1 $name`
  fi
done
