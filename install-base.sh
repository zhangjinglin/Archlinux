#!/bin/bash
timedatectl set-ntp true
cp config/etc/pacman/pacman.conf /etc/pacman.conf
cp config/etc/pacman/mirrorlist /etc/pacman.d/mirrorlist
mkfs.vfat /dev/sda1
mkfs.ext4 -L ArchRootFS /dev/sda2
mount /dev/sda2 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
pacstrap /mnt base base-devel linux linux-firmware networkmanager vim refind-efi intel-ucode git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
