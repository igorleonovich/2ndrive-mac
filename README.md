# 2ndrive
Bash script for auto ejecting 2nd drive on a Mac OS' boot

## Steps
1. Open Terminal, run `diskutil list`. 
2. Find `/dev/disk*` of your drive which you want to auto disable on OS' boot.
3. Run `diskutil info /dev/disk*`, copy it's `Device / Media Name`.
4. Put it into 2ndrive.sh instead of `*****YOUR DRIVE'S NAME*****`
5. Copy `local.2ndrive.plist` to `/Library/LaunchDaemons`
6. Run in Terminal `sudo launchctl load /Library/LaunchDaemons/local.2ndrive.plist`
7. Open your's `~/.bash.profile` in some text editor and add there these lines:
    `alias 2ndon='sh ~/2ndrive.sh mountDrive'`
    `alias 2ndoff='sh ~/2ndrive.sh eject'`
8. Restart your Mac

## Using
- Your drive will be automatically turned off each time Mac OS is loaded at the moment of the login screen is appeared.
- If you want to turn on your drive then run in Terminal `2ndon`
- If you want to turn off your drive after enabling it then run in Terminal `2ndoff`

Enjoy!