#!/bin/bash
#
# Automate Raspberry Pi Backups
#
# Kristofer Källsbo 2017 www.hackviking.com
#
# Usage: system_backup.sh {path} {days of retention} {-c to compress}
#
# Below you can set the default values if no command line args are sent.
# The script will name the backup files {$HOSTNAME}.{YYYYmmdd}.img
# When the script deletes backups older then the specified retention
# it will only delete files with it's own $HOSTNAME.
#

# Declare vars and set standard values
backup_path=/mnt/backup
retention_days=3
compress=0

# Check that we are root!
if [[ ! $(whoami) =~ "root" ]]; then
   echo ""
   echo "**********************************"
   echo "*** This needs to run as root! ***"
   echo "**********************************"
   echo ""
   exit
fi

# Check to see if we got command line args
if [ -n "$1" ]; then
   backup_path=$1
fi

if [ -n "$2" ]; then
   retention_days=$2
fi

# Check for compress flag in any arg position
for var in "$@"
do
   if [ "$var" == "-c" ]; then
      compress=1
   fi
done

# Create trigger to force file system consistency check if image is restored
touch /boot/forcefsck

# Perform backup
if [ "$compress" == 1 ]; then
   dd bs=1M if=/dev/mmcblk0 | gzip > "$backup_path"/"$HOSTNAME"."$(date +%Y%m%d)".img.gz
else
   dd if=/dev/mmcblk0 of="$backup_path"/"$HOSTNAME"."$(date +%Y%m%d)".img bs=1M
fi

# Remove fsck trigger
rm /boot/forcefsck

# Delete old backups
find "$backup_path"/"$HOSTNAME".*.img* -mtime +"$retention_days" -type f -delete
