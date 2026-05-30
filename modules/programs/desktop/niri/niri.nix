{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.niri = {pkgs, ...}: {
    imports = [inputs.niri.nixosModules.niri];

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.niri
    ];

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

        spawn-at-startup = [];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

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

        switch-events = {
          # TODO: make something but only if workstation/laptop (if needed)
          # lid-close.action.spawn = [];
          # lid-open.action.spawn = [];
        };

        binds = let
          dms_reboot_cmd = [
            "sh"
            "-c"
            "systemctl --user stop dms.service;
            pkill dms; pkill quickshell;
            rm -rf $XDG_RUNTIME_DIR/quickshell;
            systemctl --user start dms.service"
          ];

          bindWorkspaces = mod: action:
            lib.listToAttrs (map (i: {
              name = "${mod}+${
                if i == 10
                then "0"
                else toString i
              }";
              value.action.${action} = [i];
            }) (lib.range 1 10));

          dms_bind = cmd: ["dms" "ipc" "call"] ++ (lib.splitString " " cmd);
        in
          lib.attrsets.mergeAttrsList [
            # Workspace
            (bindWorkspaces "Mod" "focus-workspace")
            (bindWorkspaces "Mod+Shift" "move-column-to-workspace")

            {
              # TODO: Move to system constants
              # "Mod+Return".action.spawn = [config.modules.desktop.terminal.spawnCmd];
              # "Mod+B".action.spawn = [config.modules.desktop.browser.spawnCmd];
              "Mod+Shift+C".action.close-window = {};
              "Mod+Shift+C".repeat = false;
              "Ctrl+Alt+Backspace".action.quit = {};
              "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = {};
              "Mod+Shift+F".action.fullscreen-window = {};

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

              # Media
              "Alt+Shift+K".action.spawn = dms_bind "mpris playPause";
              "Alt+Shift+J".action.spawn = dms_bind "mpris previous";
              "Alt+Shift+L".action.spawn = dms_bind "mpris next";
              "Alt+Shift+Backspace".action.spawn = dms_bind "mpris stop";

              "Print".action.screenshot = {};
              "Print".hotkey-overlay.title = "Open interactive screenshot tool";
              "Mod+Alt+P".action.screenshot-screen = {};
              "Mod+Alt+P".hotkey-overlay.title = "Screenshot screen";
              "Alt+Print".action.screenshot-screen = {show-pointer = false;};
              "Alt+Print".hotkey-overlay.title = "Screenshot screen without pointer";
              "Mod+Alt+P".action.screenshot-screen = {};
              "Mod+Ctrl+P".action.screenshot-window = {};
              "Mod+Ctrl+P".hotkey-overlay.title = "Screenshot window";

              "Mod+Tab".action.spawn = dms_bind "spotlight toggle";
              "Mod+Tab".hotkey-overlay.title = "Open spotlight search";

              "Mod+D".action.spawn = dms_bind "clipboard toggle";
              "Mod+D".hotkey-overlay.title = "Open clipboard manager";

              # Menus, dashs and etc
              "Mod+Shift+M".action.spawn = dms_bind "dash toggle media";
              "Mod+Shift+M".hotkey-overlay.title = "Open media menu";
              "Mod+Shift+N".action.spawn = dms_bind "notifications toggle";
              "Mod+Shift+N".hotkey-overlay.title = "Open notifications menu";
              "Mod+Shift+E".action.spawn = dms_bind "dankdash wallpaper";
              "Mod+Shift+E".hotkey-overlay.title = "Open wallpaper switcher";
              "Mod+Shift+I".action.spawn = dms_bind "control-center toggle";
              "Mod+Shift+I".hotkey-overlay.title = "Open control center";
              "Mod+Shift+O".action.spawn = dms_bind "dash toggle ";
              "Mod+Shift+O".hotkey-overlay.title = "Open overview";
              "Mod+Shift+P".action.spawn = dms_bind "powermenu toggle";
              "Mod+Shift+P".hotkey-overlay.title = "Open powermenu";
              "Mod+Shift+L".action.spawn = dms_bind "lock lock";
              "Mod+Shift+L".hotkey-overlay.title = "Lock machine";
              "Mod+Shift+Slash".action.spawn = dms_bind "keybinds toggle niri";

              "Mod+Shift+Delete".action.spawn = dms_reboot_cmd;
              "Mod+Shift+Delete".hotkey-overlay.title = "Lock machine";

              "Ctrl+Alt+Bracketright".action.spawn = dms_bind "wallpaper next";
              "Ctrl+Alt+Bracketleft".action.spawn = dms_bind "wallpaper prev";

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

              # OSD's
              "Mod+Shift+Period".action.spawn = dms_bind "audio increment 5%";
              "Mod+Shift+Period".allow-when-locked = true;
              "Mod+Shift+Period".hotkey-overlay.title = "Increase volume";

              "Mod+Shift+Comma".action.spawn = dms_bind "audio decrement 5%";
              "Mod+Shift+Comma".allow-when-locked = true;
              "Mod+Shift+Comma".hotkey-overlay.title = "Decrease volume";

              "XF86AudioRaiseVolume".action.spawn = dms_bind "audio increment 5%";
              "XF86AudioRaiseVolume".allow-when-locked = true;
              "XF86AudioRaiseVolume".hotkey-overlay.title = "Increase volume";

              "XF86AudioLowerVolume".action.spawn = dms_bind "audio decrement 5%";
              "XF86AudioLowerVolume".allow-when-locked = true;
              "XF86AudioLowerVolume".hotkey-overlay.title = "Decrease volume";

              "XF86AudioMute".action.spawn = dms_bind "audio mute";
              "XF86AudioMute".allow-when-locked = true;
              "XF86AudioMute".hotkey-overlay.title = "Mute audio";

              "XF86AudioMicMute".action.spawn = dms_bind "audio micmute";
              "XF86AudioMicMute".allow-when-locked = true;
              "XF86AudioMicMute".hotkey-overlay.title = "Mute microphone";

              "XF86MonBrightnessUp".action.spawn = dms_bind "brightness increment 5% ";
              "XF86MonBrightnessUp".allow-when-locked = true;
              "XF86MonBrightnessUp".hotkey-overlay.title = "Increase brightness";

              "XF86MonBrightnessDown".action.spawn = dms_bind "brightness decrement 5% ";
              "XF86MonBrightnessDown".allow-when-locked = true;
              "XF86MonBrightnessDown".hotkey-overlay.title = "Decrease brightness";
            }
          ];
      };
    };
  };
}
