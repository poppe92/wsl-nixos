# wsl-nixos


setup a wsl-nixos with zsh and other fun stuff for my work


# To install:
1. Install per wsl - nixos guide
2. edit `/etc/nixos/configuration.nix` to also contain
```
  environment.systemPackages = [
    pkgs.git
  ];  
```
3. clone repo to home (or prefered)
4. run:
```
sudo nixos-rebuild boot --flake ~/nixConfig/#default
```
5. Restart WSL with `wsl --shutdown` and reenter with `wsl -d NixOS` twice to get .zshrc to actually load
6. verify that it works with `sudo nix-channel --update` (can not be run in a Powershell originated shell, needs a new tab in terminal).


