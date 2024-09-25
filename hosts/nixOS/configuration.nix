# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>

    inputs.home-manager.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Install Zsh and use as default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    neovim
    jq
    quarkus

    # Terminal programs
    silver-searcher # Better find files

    # Zsh Used Packages
    lolcat
    cowsay
    fortune
    
    bat # Cat replacement
    eza # LS replacement
    
    # Build Tools
    maven
    
    

  ];

  home-manager = {
    # Also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nixos" = import ./home.nix;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
