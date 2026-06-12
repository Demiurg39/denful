# modules/system/settings/network/resolved.nix
{inputs, ...}: {
  flake.modules.nixos.resolved = {
    services.resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        DNSSEC = false;
        DNS = [
          "${inputs.self.const.network.dns.cloudflare.v4}#${inputs.self.const.network.dns.cloudflare.hostname}"
        ];
      };
    };
  };
}
