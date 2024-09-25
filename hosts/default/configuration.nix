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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  wsl = {
    enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;
    wslConf.network.generateResolvConf = false;
  };

  networking.nameservers = [
    "172.28.96.1"
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 14d";
    };
  };

  environment.systemPackages = with pkgs; [

    # Development Tools
    firefox
    google-chrome
    git
    neovim
    nil
    alejandra # Nix Formatter for Neovim
    python3
    jq
    fx
    quarkus
    _7zz
    kubectl
    k9s
    zip
    
    # Terminal programs
    silver-searcher # Better find files
    bat # Cat replacement
    eza # LS replacement

    # Zsh Used Packages
    lolcat
    cowsay
    fortune
    
    # Build Tools
    maven
    (azure-cli.withExtensions [
      azure-cli.extensions.azure-devops
    ])
    docker_26
    nodejs
    yarn
    steam-run
    
    # IDEA tools
    jetbrains.idea-ultimate 

    # Standalone 
    xorg.xeyes
  ];

#environment.systemPackages = [
#  (azure-cli.withExtensions 
#    [ azure-cli.extensions.aks-preview ]
#  );
#];

  # Install Zsh and use as default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    interactiveShellInit = ''eval "$(direnv hook zsh)"'';
  };
 
  # Docker daemon
  virtualisation.docker.enable = true;
  ### "nixos" here is the system user, rename
  users.users.nixos.extraGroups = [ "docker" ];

  # Enable Java
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  home-manager = {
    # Also pass inputs to home-manager modules
    useGlobalPkgs = true; # due to Intellij being unfree, and referenced in zshrc.nix, this is needed
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nixos" = import ./home.nix;
    };
  };


  environment.variables = rec {
    # Environment Variables
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
