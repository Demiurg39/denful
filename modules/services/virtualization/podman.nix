{
  flake.modules.nixos.podman = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      recomendedDefaults = true;
    };
  };
}
