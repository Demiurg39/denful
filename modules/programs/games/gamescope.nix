{
  flake.modules.nixos.gamescope = {
    programs = {
      gamescope = {
        enable = true;
        # TODO: check if this still true
        # NOTE produces error:
        # failed to inherit capabilities: Operation not permitted
        # check https://discourse.nixos.org/t/unable-to-activate-gamescope-capsysnice-option/37843
        capSysNice = true;
        args =
          [
            "--rt"
            "--grab"
            "--force-grab-cursor"
          ]
          # TODO: Move to system constants
          # ++ optionals (config.modules.desktop.type == "wayland") ["--expose-wayland"]
          ;
      };
    };
  };
}
