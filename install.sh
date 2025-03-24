
#restore pacman packages
echo "installing pacman packages..."
pacman -S --needed - < pacman_pkgs.txt

#restore aur packages
pacman -S --needed base-devel git
mkdir ~/Repositories
cd ~/Repositories
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sfi
echo "yay installed: "
yay --version
echo "installing aur packages..."
yay -S --needed - < aur_pkgs.txt

#setup firewall
echo "setting up firewall..."

ufw default allow outgoing
ufw default deny incoming
ufw allow 22/tcp
enable ufw
ufw status

#additional startup services
echo "adding power profiles service"
sudo systemctl enable power-profiles-daemon.service
echo "adding timeshift service"
sudo systemctl enable --now cronie
echo "adding bluetooth service"
sudo systemctl enable --now bluetooth

#set cursor
echo "setting cursor..."
echo 'gtk-cursor-theme-name="Bibata-Modern-Ice"' >> ~/.gtkrc-2.0
echo -e "[Settings]\ngtk-cursor-theme-name=Bibata-Modern-Ice" >> ~/.config/gtk-3.0/settings.ini

#set brave persistent flag
echo "setting brave persistent flag..."
echo "--password-store=basic" >> ~/.config/brave-flags.conf

#create sym links for dotfiles
echo "setting up dotfiles..."

ln -sf ~/Repositories/catppuccin-hyprland/.config/hypr/ ~/.config/hypr
ln -sf ~/Repositories/catppuccin-hyprland/.config/scripts ~/.config/scripts
ln -sf ~/Repositories/catppuccin-hyprland/.bashrc ~/.bashrc
ln -sf ~/Repositories/catppuccin-hyprland/.config/rofi ~/.config/rofi
ln -sf ~/Repositories/catppuccin-hyprland/.config/dunst ~/.config/dunst

mkdir -p ~/.config/waybar
ln -sf ~/Repositories/catppuccin-hyprland/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/Repositories/catppuccin-hyprland/.config/waybar/style2.css ~/.config/waybar/style.css
ln -sf ~/Repositories/catppuccin-hyprland/catppuccin/waybar/mocha.css ~/.config/waybar/mocha.css

ln -sf ~/Repositories/catppuccin-hyprland/.config/kitty ~/.config/kitty
ln -sf ~/Repositories/catppuccin-hyprland/.config/neofetch ~/.config/neofetch

mkdir -p ~/.config/fastfetch
ln -sf ~/Repositories/catppuccin-hyprland/.config/fastfetch/full.jsonc ~/.config/fastfetch/config.jsonc

ln -sf ~/Repositories/catppuccin-hyprland/.config/starship/starship.toml ~/.config/starship.toml
ln -sf ~/Repositories/catppuccin-hyprland/.config/wlogout ~/.config/wlogout

echo "All done!"
echo "press any key to reboot..."
read -n 1 -s
echo "rebooting..."
reboot
