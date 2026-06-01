{lib, ...}: {
  flake.modules.nixos.nh = {
    programs.nh = {
      enable = true;

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 3";
      };
    };
    nix.gc.automatic = lib.mkForce false;
  };
}
