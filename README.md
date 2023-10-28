# BASH-RaspberryPI-System-Backup

Bash script for automatic imaging backup of a Raspberry Pi system while running.  It also cleans out the backups older than the set retention period in days.

You can have several Raspberry Pi backups in the same location since it will only clean its backups based on `$HOSTNAME`.

## Install

``` bash
wget https://github.com/kallsbo/BASH-RaspberryPI-System-Backup/raw/master/system_backup.sh
chmod +x system_backup.sh
```

## Use

For the script to work, you need either a mounted share or a mounted USB stick.

You can update the default values in the script in regards to backup path and retention or provide it as command line parameters.

Example: `sudo ./system_backup.sh /mnt/usbstick 7`

This will put the backup in `/mnt/usbstick`` and keep the backups for 7 days before cleaning them out.

## Compression

If you desire a compressed image, you may use the optional `-c` flag at the end of your invocation.

Example: `sudo ./system_backup.sh /mnt/usbstick 7 -c`

Compression, especially on a Pi Zero, takes a significantly longer amount of time.

## Automate

Once you have tested the script and are done with the settings, you can automate this by adding it to `cron`.  Since it needs to run as root, you need to edit the root crontab like this:

`sudo crontab -e`

If asked to select an editor, I usually use the default option 2 - nano.  Then add the line:

`0 3 * * * /mnt/backup/system_backup.sh`

This will make the script take a full image backup every night at 3 a.m.
