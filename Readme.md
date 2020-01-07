# Arch Linux and i3wm Configuration

1. Boot the ArchLinux ISO
2. Press `e` edit the kernel parameters for HiDPI Display
    ```
    vga = 792 // 1024x786x24
    ```
3. Set the time Server
    ```bash
    timedatectl set-ntp true
    ```

4. Select mirror list, put the server to top
    ```
    vim /etc/pacman.d/mirrorlist // 163
    ```

5. use `gdisk /dev/sda` to partition. create a `EFI 500M ef00` part, and rest to `ext4`. use `o` to create a new gpt disk, and `n` to create part, `w` write to the disk.
> also can use `cgdisk`

6. other command
    ```bash
    mkfs.vfat /dev/sda1
    mkfs.ext4 -L ArchRootFS /dev/sda2
    mount /dev/sda2 /mnt
    mkdir -p /mnt/boot/efi
    mount /dev/sda1 /mnt/boot/efi
    pacstrap /mnt base base-devel linux linux-firmware networkmanager vim refind-efi intel-ucode
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt
    vim /etc/locale.gen (en_US zh_CN)
    locale-gen
    echo LANG=en_US.UTF-8 > /etc/locale.conf
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    echo ArchLinux > /etc/hostname
    vim /etc/hosts
        127.0.0.1 localhost
        ::1 	       localhost
        127.0.1.1 ArchLinux.localdomain ArchLinux
    hwclock --systohc
    visudo (wheel)
    passwd
    useradd -m zhangjinglin
    usermod -aG wheel,audio,video,optical,storage zhangjinglin
    passwd zhangjinglin
    systemctl enable NetworkManager
    refind-install
    mkdir /boot/efi/EFI/BOOT
    cp /boot/efi/EFI/refind/refind_x64.efi /boot/efi/EFI/BOOT/bootx64.efi
    vim /boot/efi/EFI/refind/redind.conf
        uncomment scan_all_linux_kernels false
        edit menuentry "Arch Linux" remove disable
        "Arch Linux" {
            icon ...
            volumen "ArchRootFS"
            loader  ...
            initrd  /boot/intel-ucode
            initrd  ...
            
        }
        using vim :r! blkid read the PARTUUID
    exit
    umount -R /mnt
    reboot
    ```
7. in new system
    ```
    sudo vim /etc/pacman.conf
        Color
        TotalDownload
        ILoveCandy

        [archlinuxcn]
        Server = https://mirrors.163.com/archlinux-cn/$arch

    sudo pacman -Syy
    sudo pacman -S archlinuxcn-keyring
    [if error]
    rm -fr /etc/pacman.d/gnupg
    pacman-key --init
    pacman-key --populate archlinux
    [end if]

    sudo pacman -S xorg i3 lightdm lightdm-gtk-greeter xfce4-terminal open-vm-tools gtkmm3 xf86-input-vmmouse xf86-video-vmware fcitx-im fcitx-configtool fcitx-rime picom rofi pcmanfm feh git


