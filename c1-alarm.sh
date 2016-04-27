#!/usr/bin/bash -vx

DEVICE=/dev/sdi
# FILE=/home/user/Downloads/ArchLinuxARM-rpi-latest.tar.gz 
FILE_URL=http://archlinuxarm.org/os/ArchLinuxARM-odroid-c1-latest.tar.gz
FILE=ArchLinuxARM-odroid-c1-latest.tar.gz

cd /tmp

if [ -e "$FILE" ]; then
    rm $FILE
fi
    
wget "$FILE_URL"

bsdtar -xpf $FILE -C root

mkfs.vfat ${DEVICE}1

if [ -d "boot" ]; then
    rm -R boot
fi

mkdir boot

mount ${DEVICE}1 boot

mkfs.ext4 ${DEVICE}2

if [ -d "root" ]; then
    rm -R root
fi

mkdir root

mount ${DEVICE}2 root

bsdtar -xpf $FILE -C root

sync

mv root/boot/* boot

umount boot root

sync
