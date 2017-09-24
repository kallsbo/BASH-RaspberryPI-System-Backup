# BASH-RaspberryPI-System-Backup
Bash script for automatic imaging backup of a raspberry pi system while it's running 
It also cleans out the backups older then the set retention period in days.
You can have several Raspberry Pi's backup to the same location since it will only clean 
it's own backups based on $HOSTNAME.

## Install

wget https://github.com/kallsbo/BASH-RaspberryPI-System-Backup/raw/master/system_backup.sh
chmod +x system_backup.sh

## Use

In order for the script to work you need either a mounted share or a mounted usb stick.
Either you can update the defualt values in the script in regards to backup path and retention or
provide it as command line parameters.

Example: sudo ./system_backup.sh /mnt/usbstick 7

This will put the backup in /mnt/usbstick and keep the backups for 7 days before cleaning them out.

## Automate

Once you have tested the script and are done with the settings you can automate this bu adding it to 
crontab. Since it needs to run as root you need to edit the root crontab like this:

sudo crontab -e

I usally go for the default option 2 - nano. Then just add the line

0 3 * * * /mnt/backup/system_backup.sh

This will make the script take a full image backup every night at 3 am.
