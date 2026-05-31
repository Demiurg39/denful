# age-encrypted secrets for NixOS / Darwin and Home Manager
# https://github.com/ryantm/agenix
{inputs, ...}: {
  flake-file.inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.home-manager.follows = "home-manager";

    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";
    agenix-rekey.inputs.flake-parts.follows = "flake-parts";

    secrets = {
      url = "path:./secrets";
      flake = false;
    };
  };

  imports = [inputs.agenix-rekey.flakeModule];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = [
        config.agenix-rekey.package
        pkgs.rage
      ];
    };
  };
}
