# shell.nix

{ 
description = "Flake to manage my Java workspace.";

inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
inputs.flake-utils.url = "github:numtide/flake-utils";

outputs = inputs: 
let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in { 
  devShell.${system} = pkgs.mkShell rec {
    name = "java-shell";
    nativeBuildInputs = with pkgs; [ 
      jdk11 
    ];
    
    shellHook = ''
      export JAVA_HOME=${pkgs.jdk11}
      PATH="${pkgs.jdk11}/bin:$PATH"
    '';
  };
 };
}
