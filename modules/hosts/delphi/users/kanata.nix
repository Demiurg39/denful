{
  flake.modules.nixos.delphi = {lib, ...}: {
    services.kanata.enable = lib.mkForce false;
  };
}
