# Manage a user environment using Nix
# https://github.com/nix-community/home-manager
{inputs, ...}: {
  flake-file.inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];
}
