```sh
git clone <repo> ~/dotfiles
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/hosts/nixos/
```

```sh
cd ~/dotfiles
sudo nixos-rebuild switch --flake .#nvidia-plasma
# oder:
sudo nixos-rebuild switch --flake .#nvidia-hyprland

# AMD bzw. Intel entsprechend:
# .#amd-plasma, .#amd-hyprland, .#intel-plasma, .#intel-hyprland
```
