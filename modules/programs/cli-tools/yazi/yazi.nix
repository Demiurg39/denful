{
  flake.modules.homeManager.yazi = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      shellWrapperName = "yy";
      extraPackages = with pkgs; [
        mediainfo
        exiftool
      ];

      keymap = {};
      plugins = {};
      settings = {
        mgr = {
          sort_by = "natural";
          sort_dir_first = true;
          linemode = "none";
          show_hidden = true;
          show_symlink = true;
          scrolloff = 10;
        };
      };
    };
  };
}
