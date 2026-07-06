{
  flake.modules.nixos.winboat = {pkgs, ...}: {
    environment.systemPackages = [pkgs.winboat];
  };
}
