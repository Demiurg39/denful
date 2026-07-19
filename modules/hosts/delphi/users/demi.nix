{inputs, ...}: {
  flake.modules.nixos.delphi = {
    imports = with inputs.self.modules.nixos; [
      demi-cli
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
    ];
  };
}
