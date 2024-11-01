
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
#sym links for dotfiles
ln -sf ~/Repositories/catppuccin-hyprland/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/Repositories/catppuccin-hyprland/.config/hypr/hyprlock.conf ~/.config/hypr/hyprlock.conf
ln -sf ~/Repositories/catppuccin-hyprland/.config/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf

ln -sf ~/Repositories/catppuccin-hyprland/.bashrc ~/.bashrc

ln -sf ~/Repositories/catppuccin-hyprland/.config/scripts/ ~/.config

ln -sf ~/Repositories/catppuccin-hyprland/.config/rofi ~/.config/rofi
ln -sf ~/Repositories/catppuccin-hyprland/.config/dunst ~/.config/dunst

mkdir ~/.config/waybar
ln -sf ~/Repositories/catppuccin-hyprland/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/Repositories/catppuccin-hyprland/.config/waybar/style2.css ~/.config/waybar/style.css
ln -sf ~/Repositories/catppuccin-hyprland/catppuccin/waybar/mocha.css ~/.config/waybar/mocha.css

sudo rm ~/.config/kitty
ln -sf ~/Repositories/catppuccin-hyprland/.config/kitty ~/.config/kitty

ln -sf ~/Repositories/catppuccin-hyprland/.config/neofetch ~/.config/neofetch

mkdir ~/.config/fastfetch
ln -sf ~/Repositories/catppuccin-hyprland/.config/fastfetch/full.jsonc ~/.config/fastfetch/config.jsonc

ln -sf ~/Repositories/catppuccin-hyprland/.config/starship/starship.toml ~/.config/starship.toml

ln -sf ~/Repositories/catppuccin-hyprland/.config/wlogout ~/.config/wlogout

echo "done!"
echo "press any key to reboot..."
read -n 1 -s
reboot
