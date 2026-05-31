{inputs, ...}: {
  # TODO: maybe switch to spotify-player
  flake.modules.homeManager.spotify = {pkgs, ...}: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    programs.spicetify = let
      spicepkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
