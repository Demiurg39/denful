{
  flake.modules.nixos.services.vaultwarden = {
    services.vaultwarden = {
      enable = true;
      recommendedDefaults = true;
      dbBackend = "postgresql";

      config = {
        websocketEnabled = true;
        webVaultEnabled = true;
      };
    };
  };
}
