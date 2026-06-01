# modules/system/settings/network/constants.nix
{
  config.flake.lib.network = {
    dns = {
      quad9 = {
        v4 = "9.9.9.9";
        v6 = "2620:fe::fe";
        hostname = "dns.quad9.net";
      };
      cloudflare = {
        v4 = "1.1.1.1";
        v6 = "2606:4700:4700::1111";
        hostname = "cloudflare-dns.com";
      };
    };
  };
}
