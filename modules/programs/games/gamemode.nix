{
  flake.modules.nixos.gamemode = {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };
      };
    };

    # TODO: Use factory
    # user.extraGroups = ["gamemode"];
  };
}
