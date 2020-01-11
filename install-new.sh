cp config/etc/locale.gen /etc/locale.gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo ArchLinux > /etc/hostnam
cp /config/etc/hosts /etc/hosts
hwclock --systohc
passwd
useradd -m zhangjinglin
usermod -aG wheel,audio,video,optical,storage zhangjinglin
passwd zhangjinglin
systemctl enable NetworkManager
refind-install
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/refind/refind_x64.efi /boot/efi/EFI/BOOT/bootx64.efi
cp config/boot/refind.conf /boot/efi/EFI/refind/refind.conf

pacman -Syy
rm -fr /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman -S archlinuxcn-keyring
pacman -S xorg i3 lightdm lightdm-gtk-greeter xfce4-terminal fcitx-im fcitx-configtool fcitx-rime picom rofi pcmanfm feh fish ttf-cascadia-code yay noto-fonts-cjk polybar alsa-utils lxappearance arc-gtk-theme neofetch gvfs gvfs-smb tumbler gnome-keyring libsecret
systemctl enable lightdm
cp config/Xresources /home/zhangjinglin/.Xresources
cp -r config/xfce4/ /home/zhangjinglin/.config/
cp config/xinitrc /home/zhangjinglin/.xinitrc
groupadd -r autologin
gpasswd -a zhangjinglin autologin
cp config/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
mkdir /home/zhangjinglin/Wallpaper
cp backgound.jpg /home/zhangjinglin/Wallpaper
mkdir /home/zhangjinglin/.config/picom
cp config/i3/config /home/zhangjinglin/.config/i3/
cp config/picom/picom.conf /home/zhangjinglin/.config/picom/
cp -r config/polybar/ /home/zhangjinglin/.config/
cp config/vimrc /home/zhangjinglin/.vimrc
cp config/vimrc /root/.vimrc
git config --global user.email "zhangjinglin@gmail.com"
git config --global user.name "zhangjinglin"
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret
