{inputs, ...}: let
  settings = {
    input.keyboard.xkb.variant = "colemak_dh,";
    window-rules = [
      {
        matches = [{app-id = "com\.(ayu|tele)gram\.desktop";}];
        open-on-workspace = "4";
      }
      {
        matches = [{app-id = "steam";}];
        open-on-workspace = "6";
        open-maximized = true;
        open-floating = false;
      }
      {
        matches = [
          {app-id = "steam";}
          {title = "Friends List";}
        ];
        open-on-workspace = "6";
        open-floating = true;
      }
      {
        matches = [{app-id = "spotify";}];
        open-on-workspace = "9";
      }
    ];
  };
in {
  flake.modules.homeManager.demi-desktop = {
    programs.niri.settings = settings;
  };

  flake.modules.homeManager.demi-desktop-standalone = {
    imports = [inputs.niri.homeModules.niri];
    programs.niri.settings = settings;
  };
}
