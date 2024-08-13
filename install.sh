
#restore pacman packages
echo "installing pacman packages..."
pacman -S --needed - < pacman_pkgs.txt

#restore aur packages
pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "yay installed: "
yay --version
echo "installing aur packages..."
yay -S --needed - < aur_pkgs.txt

#setup firewall
echo "setting up firewall..."
systemctl start ufw
systemctl enable ufw

ufw default allow outgoing
ufw default deny incoming

ufw allow 22/tcp
ufw status

#additional startup services
echo "adding power profiles service"
sudo systemctl enable power-profiles-daemon.service
echo "adding timeshift service"
sudo systemctl enable --now cronie

#sym links for dotfiles
ln -s ~/Repositories/catppuccin-hyprland/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -s ~/Repositories/catppuccin-hyprland/.config/hypr/hyprpicker.conf ~/.config/hypr/hyprpicker.conf
ln -s ~/Repositories/catppuccin-hyprland/.config/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf

ln -s ~/Repositories/catppuccin-hyprland/.config/neofetch/config.conf ~/.config/neofetch/config.conf

ln -s ~/Repositories/catppuccin-hyprland/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc

ln -s ~/Repositories/catppuccin-hyprland/.config/starship/starship.toml ~/.config/starship.toml

ln -s ~/Repositories/catppuccin-hyprland/.config/wlogout/assets ~/.config/wlogout/assets
ln -s ~/Repositories/catppuccin-hyprland/.config/wlogout/style.css ~/.config/wlogout/style.css
ln -s ~/Repositories/catppuccin-hyprland/.config/wlogout/layout ~/.config/wlogout/layout

ln -s ~/Repositories/catppuccin-hyprland/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/Repositories/catppuccin-hyprland/.config/kitty/theme.conf ~/.config/kitty/theme.conf

ln -s ~/Repositories/catppuccin-hyprland/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/Repositories/catppuccin-hyprland/.config/waybar/style.css ~/.config/waybar/style.css

ln -s ~/Repositories/catppuccin-hyprland/.bashrc ~/.bashrc

ln -s ~/Repositories/catppuccin-hyprland/.config/scripts/memory.sh ~/.config/scripts/memory.sh
ln -s ~/Repositories/catppuccin-hyprland/.config/scripts/logout.sh ~/.config/scripts/logout.sh
ln -s ~/Repositories/catppuccin-hyprland/.config/scripts/rofi.sh ~/.config/scripts/rofi.sh
ln -s ~/Repositories/catppuccin-hyprland/.config/scripts/mediaplayer.py ~/.config/scripts/mediaplayer.py

#install fonts
yay -S ttf-work-sans
yay -S ttf-space-mono-nerd
yay -S ttf-jetbrains-mono
yay -S ttf-3270-nerd
yay -S ttf-cascadia-code-nerd

echo "done!"
echo "rebooting..."
sudo reboot
