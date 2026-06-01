# modules/system/settings/network/resolved.nix
{inputs, ...}: {
  flake.modules.nixos.resolved = {
    services.resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        DNSSEC = false;
        fallbackDns = [
          "${inputs.self.lib.network.dns.cloudflare.v4}#${inputs.self.lib.network.dns.cloudflare.hostname}"
        ];
      };
    };
  };
}
