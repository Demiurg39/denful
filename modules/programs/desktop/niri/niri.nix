{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = [inputs.niri.nixosModules.niri];

    home-manager.sharedModules = [inputs.self.modules.homeManager.niri];

    nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
  };

  flake.modules.homeManager.niri = {pkgs, ...}: {
    home.packages = [
      pkgs.bibata-cursors
      pkgs.wl-mirror # for mirroring
    ];

    programs.niri = {
      settings = {
        input = {
          mod-key = "Super";
          keyboard.xkb = {
            layout = "us,ru";
            options = "grp:win_space_toggle";
          };
          warp-mouse-to-focus = {};
          focus-follows-mouse.enable = true;
        };

        layout = {
          border = {
            enable = false;
            width = 8;
            active = {};
            inactive = {};
            urgent = "";
          };
          gaps = 12;
        };
        gestures.hot-corners.enable = false;
        screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png";

        cursor = {
          size = 24;
          theme = "Bibata-Modern-Ice";
          hide-after-inactive-ms = 500;
        };

        environment = {
          QT_QPA_PLATFORM = "wayland";
          GDK_BACKEND = "wayland";
          NIXOS_OZONE_WL = "1";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          XCURSOR_THEME = "Bibata-Modern-Ice";
          XCURSOR_SIZE = "24";
        };

        animations = {
          enable = true;
          workspace-switch = {
            enable = true;
            kind.spring = {
              damping-ratio = 0.8;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
        };

        workspaces = lib.listToAttrs (map (i: {
          name = "${lib.toString i}";
          value = {};
        }) (lib.range 1 9));

        binds = let
          bindWorkspaces = mod: action:
            lib.listToAttrs (map (i: {
              name = "${mod}+${
                if i == 10
                then "0"
                else toString i
              }";
              value.action.${action} = [i];
            }) (lib.range 1 10));
        in
          lib.attrsets.mergeAttrsList [
            (bindWorkspaces "Mod" "focus-workspace")
            (bindWorkspaces "Mod+Shift" "move-column-to-workspace")
            {
              # TODO: Move to system constants
              "Mod+Return".action.spawn = ["kitty"];
              "Mod+B".action.spawn = ["qutebrowser"];
              "Mod+Shift+C".action.close-window = {};
              "Mod+Shift+C".repeat = false;
              "Ctrl+Alt+Backspace".action.quit = {};
              "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = {};
              "Mod+Shift+F".action.fullscreen-window = {};

              "Mod+Alt+Comma".action.maximize-window-to-edges = {};
              "Mod+Alt+Period".action.maximize-column = {};
              "Mod+Alt+R".action.switch-preset-column-width = {};

              "Mod+O".action.toggle-overview = {};
              "Mod+O".repeat = false;

              # Navigation
              "Mod+Bracketleft".action.focus-column-or-monitor-left = {};
              "Mod+J".action.focus-workspace-down = {};
              "Mod+K".action.focus-workspace-up = {};
              "Mod+Bracketright".action.focus-column-or-monitor-right = {};

              "Mod+Shift+Bracketleft".action.move-column-left = {};
              "Mod+Shift+J".action.move-column-to-workspace-down = {};
              "Mod+Shift+K".action.move-column-to-workspace-up = {};
              "Mod+Shift+Bracketright".action.move-column-right = {};

              "Print".action.screenshot = {};
              "Print".hotkey-overlay.title = "Open interactive screenshot tool";
              "Mod+Alt+P".action.screenshot-screen = {};
              "Mod+Alt+P".hotkey-overlay.title = "Screenshot screen";
              "Alt+Print".action.screenshot-screen = {show-pointer = false;};
              "Alt+Print".hotkey-overlay.title = "Screenshot screen without pointer";
              "Mod+Alt+P".action.screenshot-screen = {};
              "Mod+Ctrl+P".action.screenshot-window = {};
              "Mod+Ctrl+P".hotkey-overlay.title = "Screenshot window";

              # # The following binds move the focused window in and out of a column.
              # # If the window is alone, they will consume it into the nearby column to the side.
              # # If the window is already in a column, they will expel it out.
              # Mod+BracketLeft  { consume-or-expel-window-left; }
              # Mod+BracketRight { consume-or-expel-window-right; }
              #
              # # Consume one window from the right to the bottom of the focused column.
              # Mod+Comma  { consume-window-into-column; }
              # # Expel the bottom window from the focused column to the right.
              # Mod+Period { expel-window-from-column; }
              #
              # Mod+R { switch-preset-column-width; }
              # # Cycling through the presets in reverse order is also possible.
              # # Mod+R { switch-preset-column-width-back; }
              # Mod+Shift+R { switch-preset-window-height; }
              # Mod+Ctrl+R { reset-window-height; }
              # Mod+F { maximize-column; }
              # Mod+Shift+F { fullscreen-window; }
              # Mod+M { maximize-window-to-edges; }
              #
              # # Expand the focused column to space not taken up by other fully visible columns.
              # # Makes the column "fill the rest of the space".
              # Mod+Ctrl+F { expand-column-to-available-width; }
              #
              # Mod+C { center-column; }
              #
              # # Center all fully visible columns on screen.
              # Mod+Ctrl+C { center-visible-columns; }
            }
          ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
      };
    };
  };
}
