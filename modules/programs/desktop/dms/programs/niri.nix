{
  inputs,
  lib,
  ...
}: let
  dms_reboot_cmd = [
    "sh"
    "-c"
    "systemctl --user stop dms.service;"
    "pkill dms; pkill quickshell;"
    "rm -rf $XDG_RUNTIME_DIR/quickshell;"
    "systemctl --user start dms.service"
  ];

  dms_bind = cmd: ["dms" "ipc" "call"] ++ (lib.splitString " " cmd);
in {
  flake.modules.homeManager.dms = {
    imports = [inputs.dms.homeModules.niri];

    programs.niri.settings = {
      binds = {
        # Media
        "Alt+Shift+K".action.spawn = dms_bind "mpris playPause";
        "Alt+Shift+J".action.spawn = dms_bind "mpris previous";
        "Alt+Shift+L".action.spawn = dms_bind "mpris next";
        "Alt+Shift+Backspace".action.spawn = dms_bind "mpris stop";

        "Mod+Tab".action.spawn = dms_bind "launcher toggle";
        "Mod+Tab".hotkey-overlay.title = "Open laucher search";

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
      };
    };
  };
}
