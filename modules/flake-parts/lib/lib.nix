# lib: config auxiliary functions
{
  config,
  inputs,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
            networking.hostName = lib.mkDefault name;
          }
        ];
      };
    };
    mkHome = {
      username,
      profile ? "default",
      systems ? config.systems,
    }:
      builtins.listToAttrs (map (system: {
          name = "${username}-${profile}-${system}";

          value = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${system};
            modules = [
              inputs.self.modules.homeManager."${username}-${profile}-standalone"
              # TODO: substitute with unfree predicate and allow only needed pkgs
              {nixpkgs.config.allowUnfree = true;}
            ];
          };
        })
        systems);
  };
}
