BGinfo = BackGround Info

BGinfo is a free to use tool created by sysinternals.

This script is used mostly by network admins to help users to get their pc name or ip more easily.

When you first execute the bginfo.bat (run it as administrator) the script searches for C:\BGinfo directory and if is not existing, it will create that directory and copy all the needed files to it, then it runs the command to get infos on the desktop also it will add a reg key to HKLM...Run to execute the same command at every start. If the directory exists then it will just run the command to display infos on the desktop.

The directory contains:
BGinfo.exe => The main program to display info on desktop
bginfo.cmd => The main file to be used to create BGinfo directory to desired location and set it up to autostart
bginfo.bgi => The BGinfo template file to display info on desktop background
The .vbs files are included in the template file. Those files were created to display only IPv4 for IP, GW, Mask and DNS.

Version 4 - 05.12.2016@01:33am
Change log:
- Added option to automatically create task per user account
- Task will run every 5 minutes
- Changed the command from the autorun registry
- Added option to delete the BGinfo task(s) if there is some left from an older setup.
- Added BGinfo registry EULA Acceptance
- Added Normal User Mode Run