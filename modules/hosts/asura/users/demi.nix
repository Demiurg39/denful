{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = with inputs.self.modules.nixos; [
      demi

      kitty

      gamescope
      gamemode
      steam
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      # ayugram
      lutris
    ];
  };
}
