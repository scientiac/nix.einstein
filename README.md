# nix.einstein
My Gnome NixOS Configuraiton

![Screenshot](screenshot.png)

## Declerative
```sh
sudo nixos-rebuild switch --flake .#einstein
```

## Imperative

- Flatpak
```sh
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
- Easyeffects
```
flatpak install flathub com.github.wwmm.easyeffects
```
