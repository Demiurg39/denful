{
  flake.modules.homeManager.xdg = {config, ...}: {
    xdg = {
      enable = true;
      mimeApps.enable = true;
      cacheHome = config.home.homeDirectory + "/.local/cache";

      userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = true;
        extraConfig = {
          SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
        };
      };
    };
  };
}
