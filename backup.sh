echo "Backing up all packages..."
#echo $PWD
#pacman packages backup
pacman -Qqen > pacman_pkgs.txt

#aur packages backup
pacman -Qqem > aur_pkgs.txt

git add .
git commit -m "updates"
git push origin main

echo "Done."
