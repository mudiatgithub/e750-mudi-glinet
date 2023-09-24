#!/bin/sh

cd /mnt/sda1/
wget https://raw.githubusercontent.com/mudiatgithub/e750-mudi-glinet/main/overlay_backup.gz
cd /overlay/upper
tar x -f /mnt/sda1/overlay_backup.gz
reboot
