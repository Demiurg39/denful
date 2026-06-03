{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = with inputs.self.modules.nixos; [
      demi

      kitty

      steam
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      cliphist

      ayugram
      lutris
      spotify
      zathura
      qutebrowser
    ];
  };
}
