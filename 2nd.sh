#!/bin/sh

if grep --quiet 'alias 2ndon=' ~/.bash_profile
  then
  continue
else
  sudo echo "
alias 2ndon='sh /Library/Scripts/2ndrive.sh mountDisk'
alias 2ndoff='sh /Library/Scripts/2ndrive.sh eject'" >> ~/.bash_profile
fi

yes | sudo cp -rf 2ndrive.sh /Library/Scripts/2ndrive.sh

names=( $(/usr/sbin/diskutil list | grep -o '/dev/disk.') )
for i in ${!names[@]}
do
  echo "$(tput setaf 2)$(tput bold)Disk $i$(tput sgr 0):"
  echo "$(/usr/sbin/diskutil info ${names[i]})\n\n\n"
done

echo "$(tput setaf 2)Enter a disk number:$(tput sgr 0)"
read number

if [ -a local.2ndrive.plist ]
then
  /usr/libexec/PlistBuddy -c "Set ProgramArguments:2 ${names[number]}" "local.2ndrive.plist"
  yes | sudo cp -rf local.2ndrive.plist ~/Library/LaunchAgents/local.2ndrive.plist
  sudo chown $USER ~/Library/LaunchAgents/local.2ndrive.plist
  launchctl load ~/Library/LaunchAgents/local.2ndrive.plist
fi
