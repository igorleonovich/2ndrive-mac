#!/bin/sh

disk=''
if [ ! -z "$2" ]
then
  disk=$2
else
  disk=( $(/usr/libexec/PlistBuddy -c "Print ProgramArguments:2" ~/Library/LaunchAgents/local.2ndrive.plist) )
fi

script -q $TMPDIR/log /usr/sbin/diskutil $1 $disk
if grep -q 'Volume failed to eject' $TMPDIR/log
then
  rm $TMPDIR/log
  IFS='/' read -ra ELEMENTS <<< "$disk"
  DISKNAME=${ELEMENTS[${#ELEMENTS[@]}-1]}
  DISKS=($(/usr/sbin/diskutil list | grep -o "\s$DISKNAME.*"))
  echo "$(tput setaf 1)Please stop the following processes:$(tput sgr 0)"
  for d in "${DISKS[@]}"
  do
    lsof "/dev/$d"
  done
fi
