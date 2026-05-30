{inputs, ...}: {
  flake.modules.nixos.kitty = {pkgs, ...}: {
    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];
    home-manager.sharedModules = [inputs.self.modules.homeManager.kitty];
  };

  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;
      keybindings = {};
      settings = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
        window_padding_width = 5;
        confirm_os_window_close = 0;
        hide_window_decorations = true;
        repaint_delay = 10;
        input_delay = 3;
        sync_to_monitor = true;
        wayland_titlebar_color = "system";
        cursor_shape = "block";
        shell_integration = true;
        background_opacity = 0.96;
        background_blur = 64;
      };
    };
  };
}
