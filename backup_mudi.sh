#!/bin/sh

newFolder="/mnt/sda1/backup_$(date +%y%m%d%H%M)"

mkdir "$newFolder"

cd /overlay/upper

tar -cf "$newFolder/overlay_backup.gz" *

cd /

tar --exclude='sys/*' --exclude='run/*' --exclude='tmp/*' --exclude='mnt/*' --exclude='dev/*' --exclude='proc/*' --exclude='overlay/*' -cf "$newFolder/root_backup.gz" *
