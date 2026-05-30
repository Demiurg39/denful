{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.gnome = {pkgs, ...}:
    lib.mkMerge [
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.gnome
        ];

        services.displayManager.gdm.enable = true;
        services.displayManager.gdm.wayland = true;

        services.desktopManager.gnome.enable = true;

        environment.sessionVariables = {
          XDG_DATA_DIRS = [
            "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
            "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
          ];
        };

        services.gnome.core-developer-tools.enable = false;
        services.gnome.games.enable = false;
        environment.gnome.excludePackages = with pkgs; [
          gnome-tour
          gnome-user-docs
          epiphany # browser
          geary # mail
        ];

        qt = {
          enable = true;
          platformTheme = "gnome";
          style = "adwaita-dark";
        };

        # Dconf settings
        programs.dconf.enable = true;
      }
      (
        lib.mkIf false {
          nixos.gnome = {
            # Gnome multi-gpu setups services
            services.switcherooControl.enable = true;
          };
        }
      )
    ];

  flake.modules.homeManager.gnome = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        enable-hot-corners = true;
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
