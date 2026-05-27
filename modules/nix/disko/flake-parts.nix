{inputs, ...}: {
  flake-file.inputs = {
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [
    inputs.disko.flakeModules.default
  ];
}
