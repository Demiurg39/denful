{
  flake.modules.nixos.blender = {pkgs, ...}: {
    # TODO: maybe add nix-warez/blender flake to pin speciffic version
    environment.systemPackages = pkgs.blender;
  };
}
