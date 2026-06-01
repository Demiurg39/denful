# modules/system/settings/network/network-manager.nix
{lib, ...}: {
  flake.modules.nixos.network-manager = {
    networking.networkmanager = {
      enable = true;

      dns = lib.mkDefault "systemd-resolved";

      unmanaged = [
        "interface-name:docker*"
        "interface-name:br-*"
        "interface-name:veth*"
      ];
    };
  };
}
