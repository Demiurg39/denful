{inputs, ...}: {
  # TODO: maybe switch to spotify-player
  flake.modules.homeManager.spotify = {config, ...}: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    programs.spicetify = let
      spicepkgs = inputs.spicetify-nix.legacyPackages.${config.hostPlatform};
    in {
      enable = true;
      wayland = true;
      enabledExtensions = with spicepkgs.extensions; [
        betterGenres
        keyboardShortcut
        shuffle
      ];

      theme = spicepkgs.themes.defaultDynamic;
    };
  };
}
