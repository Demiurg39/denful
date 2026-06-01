{inputs, ...}: {
  flake.modules.nixos.nix-index = {
    imports = [inputs.nix-index-database.nixosModules.default];
    home-manager.sharedModules = [inputs.self.modules.homeManager.nix-index];
  };

  flake.modules.homeManager.nix-index = {
    imports = [inputs.nix-index-database.homeModules.default];

    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
