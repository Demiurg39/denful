{
  flake.modules.homeManager = {pkgs, ...}: {
    home.packages = [pkgs.celluloid];

    programs.mpv = {
      enable = true;
      scripts = [];
      scriptOpts = {};
    };
  };
}
