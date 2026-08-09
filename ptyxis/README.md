# baseline for Ptyxis

One palette, both modes; Ptyxis follows the desktop style and picks the
light or dark section itself.

```sh
cp baseline.palette ~/.local/share/org.gnome.Ptyxis/palettes/
```

Flatpak: `~/.var/app/org.gnome.Ptyxis/data/org.gnome.Ptyxis/palettes/`

Verified on AlmaLinux GNOME: both sections render correctly, and Ptyxis
follows the desktop style switch live. For a non-GUI test (the palette
list is hard to pick through by eye), select the palette and flip the
desktop style from the shell:

```sh
uuid=$(gsettings get org.gnome.Ptyxis default-profile-uuid | tr -d "'")
gsettings set "org.gnome.Ptyxis.Profile:/org/gnome/Ptyxis/Profiles/$uuid/" palette baseline
gsettings set org.gnome.desktop.interface color-scheme prefer-dark   # or: default
```
