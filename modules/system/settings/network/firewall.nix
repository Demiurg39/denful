# modules/system/settings/network/firewall.nix
{
  flake.modules.nixos.firewall = {
    networking.firewall = {
      enable = true;
      allowPing = true;
      logRefusedConnections = true;
      rejectPackets = true;
    };
  };
}
