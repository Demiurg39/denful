{inputs, ...}: {
  flake.modules.homeManager.ayugram = {pkgs, ...}: let
    inherit (inputs.self.lib) assoc;
    ayugram = inputs.ayugram-desktop.packages.${pkgs.system}.ayugram-desktop;
  in {
    home.packages = [
      ayugram
    ];

    xdg.mimeApps.defaultApplications = assoc ayugram {
      "x-scheme-handler/tg" = ["org.telegram.desktop"];
    };
  };
}
