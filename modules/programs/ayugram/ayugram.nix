{inputs', ...}: let
  inherit (inputs'.self.lib) assoc;
  ayugram = inputs'.ayugram-desktop.packages.ayugram-desktop;
in {
  flake.modules.homeManager.ayugram = {
    home.packages = [
      ayugram
    ];

    xdg.mimeApps.defaultApplications = assoc ayugram {
      "x-scheme-handler/tg" = ["org.telegram.desktop"];
    };
  };
}
