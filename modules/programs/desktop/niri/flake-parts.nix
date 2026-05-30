# niri: A scrollable-tiling Wayland compositor.
#https://github.com/niri-wm/niri
{inputs, ...}: {
  flake-file.inputs = {
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
  };
}
