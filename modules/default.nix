{inputs, ...}: {
  flake-file.description = ''My denful nix configuration'';

  flake-file.inputs = {
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-file.flakeModules.default
  ];

  systems = [
    "aarch64-linux"
    "x86_64-linux"
  ];
}
