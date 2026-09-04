```sh
git clone <repo> ~/dotfiles
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/hosts/nixos/
```

```sh
cd ~/dotfiles
sudo nixos-rebuild switch --flake .#nvidia
# oder:
sudo nixos-rebuild switch --flake .#amd
# oder:
sudo nixos-rebuild switch --flake .#intel
```
