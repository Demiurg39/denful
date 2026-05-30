{inputs, ...}: {
  flake.modules.nixos.ghostty = {pkgs, ...}: {
    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
    home-manager.sharedModules = [inputs.self.modules.homeManager.ghostty];
  };

  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      systemd.enable = false;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        adjust-font-baseline = 1;
        adjust-cell-height = "15%";
        minimum-contrast = 1.3;
        font-size = 14;
        async-backend = "auto";
        background-blur = true;
        background-opacity = 0.98;
        clipboard-paste-protection = true;
        copy-on-select = false;
        cursor-style = "block";
        cursor-style-blink = true;
        theme = "Black Metal";
        quit-after-last-window-closed = true;
        quit-after-last-window-closed-delay = "5m";
        window-decoration = false;
        window-padding-x = 12;
        window-padding-y = 10;
        window-padding-balance = true;
        window-vsync = true;
      };
    };
  };
}
