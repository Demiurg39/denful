# modules/system/settings/network/wifi.nix
{inputs, ...}: {
  flake.modules.nixos.wifi = {
    imports = [
      inputs.self.modules.nixos.network-manager
      inputs.self.modules.nixos.resolved
    ];

    networking.networkmanager = {
      # iwd instead of wpa_supplicant
      wifi.backend = "iwd";

      settings = {
        wifi.scan-rand-mac-address = true;
        connection.wifi-cloned-mac-address = "stable";
        connection.ip6-privacy = 2;
      };
    };

    networking.wireless.iwd = {
      enable = true;
      settings = {
        General.AddressRandomization = "network";
        Settings.AutoConnect = true;
      };
    };
  };
}
