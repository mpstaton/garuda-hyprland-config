```fish
sudo pacman -D --asexplicit containerd
[sudo] password for mps:         
containerd: install reason has been set to 'explicitly installed'
```

```fish
sudo pacman -Dk
No database errors have been found!
```

```fish
systemctl --user list-unit-files | grep -i conky

app-conky@autostart.service                           generated -

systemctl --user disable app-conky@autostart.service
```

```fish
echo "Hidden=true" >> ~/.config/autostart/conky.desktop
```

