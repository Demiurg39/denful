{
  flake.modules.nixos.wifi = {
    networking = {
      networkmanager = {
        settings = {
          # Use a random MAC for Wi-Fi scanning
          wifi.scan-rand-mac-address = "yes";
          # Use a stable but randomized MAC for each connection
          connection.wifi-cloned-mac-address = "stable";
          connection.ethernet-cloned-mac-address = "stable";
        };
      };
    };
  };
}
