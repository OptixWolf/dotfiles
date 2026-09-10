```sh
git clone https://github.com/OptixWolf/dotfiles ~/dotfiles
cd ~/dotfiles
```

```sh
sudo nixos-rebuild switch --flake .#nvidia
# oder:
sudo nixos-rebuild switch --flake .#amd
# oder:
sudo nixos-rebuild switch --flake .#intel
```
