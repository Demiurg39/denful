{
  flake.modules.nixos.cloudflared = {
    services.cloudflared = {
      enable = true;
    };
  };
}
