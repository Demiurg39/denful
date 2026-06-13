# modules/system/settings/network/resolved.nix
{
  flake.modules.nixos.resolved = {
    services.resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        DNSSEC = false;
      };
    };
  };
}
