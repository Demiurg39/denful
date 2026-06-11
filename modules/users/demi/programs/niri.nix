{
  flake.modules.nixos.demi = {
    home-manager.users.demi = {
      programs.niri.settings = {
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
    };
  };
}
