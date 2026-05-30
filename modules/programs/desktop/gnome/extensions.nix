{
  flake.modules.homeManager.gnome = {
    pkgs,
    lib,
    ...
  }: let
    extensions = [
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.caffeine
      pkgs.gnomeExtensions.clipboard-indicator
      pkgs.gnomeExtensions.blur-my-shell
      pkgs.gnomeExtensions.just-perfection
      pkgs.gnomeExtensions.rounded-window-corners-reborn
      pkgs.gnomeExtensions.vitals
    ];
  in {
    # Gnome extensions
    "org/gnome/shell" = {
      disable-user-extensions = false; # Optionally disable user extensions entirely
      enabled-extensions = let
        getUuid = ext:
          if builtins.hasAttr "extensionUuid" ext
          then ext.extensionUuid
          else lib.gvariant.mkNothing;
      in (map getUuid extensions);
    };
  };
}
