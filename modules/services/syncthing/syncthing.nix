{
  flake.modules.nixos.syncthing = {
    services.syncthing = {
      enable = true;
      systemLaunch = true;
      openDefaultPorts = true;
    };
  };
}
