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

> 002-
6. other command
    ```bash
    mkfs.vfat /dev/sda1
    mkfs.ext4 -L ArchRootFS /dev/sda2
    mount /dev/sda2 /mnt
    mkdir -p /mnt/boot/efi
    mount /dev/sda1 /mnt/boot/efi
    pacstrap /mnt base base-devel linux linux-firmware networkmanager vim refind-efi intel-ucode git
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
        scanfor manual
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

    sudo pacman -S xorg i3 lightdm lightdm-gtk-greeter xfce4-terminal open-vm-tools gtkmm3 xf86-input-vmmouse xf86-video-vmware git
    
    sudo systemctl enable vmtoolsd
    sudo systemctl enable vmware-vmblock-fuse
    sudo systemctl enable lightdm

    reboot
    ```

8. config vmware in i3
    ```
    vim .config/i3/config
        exec --no-startup-id vmware-user-suid-wrapper

    git clone https://github.com/zhangjinglin/ArchLinux --depth 1
    cp ArchLinux/Xresources .Xresources

    reboot
    ```
    

8. config new system    
    ```
    sudo pacman -S fcitx-im fcitx-configtool fcitx-rime picom rofi pcmanfm feh fish ttf-cascadia-code yay noto-fonts-cjk polybar alsa-utils lxappearance arc-gtk-theme neofetch gvfs-smb tumbler gnome-keyring libsecret

    yay chrome

    curl -L https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf -o "MesloLGS NF Bold.ttf"
    curl -L https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf -o "MesloLGS NF Italic.ttf"
    curl -L https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf -o "MesloLGS NF Bold Italic.ttf"
    curl -L https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf -o "MesloLGS NF Regular.ttf"

    sudo mv *.ttf /usr/share/fonts/TTF/ 
    sudo fc-cache
    cp -r ArchLinux/config/xfce4/ .config/

    cp ArchLinux/config/xinitrc .xinitrc

    chsh -s /usr/bin/fish
    curl -L http://get.oh-my.fish | fish
    omf install agnoster

    sudo groupadd -r autologin
    sudo gpasswd -a zhangjinglin autologin
    vim /etc/lighdm/lightdm.conf
        autologin-guest=false
        autologin-user=zhangjinglin
        autologin-user-timeout=0
        autologin-session=i3

    alsamixer

    mkdir ~/Wallpaper
    cp ArchLinux/backgound.jpg Wallpaper
    mkdir .config/picom
    cp ArchLinux/config/i3/config .config/i3/
    cp ArchLinux/config/picom/picom.conf .config/picom/
    cp -r ArchLinux/config/polybar/ .config/
    cp -r ArchLinux/config/fish .config/
    cp ArchLinux/config/vimrc .vimrc
    sudo cp ArchLinux/config/vimrc /root/.vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    open vim :PlugInstall
    sudo cp -r .vim /root/

    reboot
    

    

