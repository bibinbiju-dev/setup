---
id: plymouth
aliases: []
tags: []
---

# PLYMOUTH CHANGES

[[VLC]]
[[ssh_git]]
[[python-nvim-setup]]
[[Render-markdown]]

## TO changes the plymouth follow these commands

1. convert the dp.png image to logo.png viva magick command as given bellow :
   magick dp.png -resize 800x180 logo.png
2. cd /usr/share/plymouth/themes/omarchy
3. sudo mv logo.png logo.png.bak
4. sudo mv ~/Pictures/logo.png
5. sudo mkinitcpio -P
6. reboot

## To use an entirely different plymouth

1. Download and extract the plymouth theme form say gnome or any other place
2. move the extracted folder to the location /usr/share/plymouth/themes/arch-mac-style[change the folder name accordinglly ]
3. then run the command : [sudo plymouth-set-default-theme arch-mac-style -R]
