{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = with inputs.self.modules.nixos; [
      niri
      dms
    ];

    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };

    home-manager.sharedModules = [
      {
        programs.niri.settings = {
          input.touchpad = {
            tap = true;
            tap-button-map = "left-right-middle";
            natural-scroll = true;
            scroll-method = "two-finger";
            drag = true;
          };

          outputs."eDP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 144.0;
            };
            variable-refresh-rate = true;
          };
        };
      }
    ];
  };
}
