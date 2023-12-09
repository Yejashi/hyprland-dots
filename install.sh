#!/usr/bin/env bash
#

#Installing lazyvim
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/LazyVim/starter ~/.config/nvim
cp custom.lua ~/.config/nvim/lua/plugins/custom.lua

#Setting up custom Firefox aesthetic
cp -r chrome /home/yejashi/.mozilla/firefox/xl89q2dc.default-release
cp user.js /home/yejashi/.mozilla/firefox/xl89q2dc.default-release

#Kitty config
mv ~/.config/kitty ~/.config/kitty.bak
cp -r kitty ~/.config/

#Ranger
mv ~/.config/ranger ~/.config/ranger.bak
cp -r ranger ~/.config/

#Rofi
mv ~/.config/rofi ~/.config/rofi.bak
cp -r rofi ~/.config/

#Waybar
mv ~/.config/waybar/ ~/.config/waybar.bak
cp -r waybar ~/.config/

#Wallpaper setup
cp wallhaven-q21vkl.jpg ~/Documents/
