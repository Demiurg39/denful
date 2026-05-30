{inputs, ...}: let
  inherit (inputs.self.lib) assoc;
in {
  flake.modules.homeManager.fragments = {pkgs, ...}: {
    home.packages = [pkgs.fragments];
    xdg.mimeApps.defaultApplications = assoc pkgs.fragments {
      x-scheme-handler = ["magnet"];
    };
  };
}
