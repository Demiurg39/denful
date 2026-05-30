{
  flake.modules.nixos.resolved = {
    services.resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        # See systemd/systemd#10579
        DNSSEC = false;
        # TODO: maybe make also host speciffic
        # Quad9 by default
        # Domains = ["dns.quad9.net"];
        # DNS = ["9.9.9.9 2620:fe::fe"];
        # FallbackDNS = ["1.1.1.1#cloudflare-dns.com"];
      };
    };

    # Tell NM to let resolved handle DNS
    networking.networkmanager.dns = "systemd-resolved";
  };
}
