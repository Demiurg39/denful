{inputs, ...}: let
  inherit (inputs.self.lib) assoc;
in {
  flake.modules.homeManager.mpv = {pkgs, ...}: {
    home.packages = [pkgs.celluloid];

    xdg.mimeApps.defaultApplications = assoc pkgs.celluloid {
      video = ["mp4" "avi" "mkv"];
    };

    programs.mpv = {
      enable = true;
      scripts = [];
      scriptOpts = {};
    };
  };
}
