{
    flake.modules.nixos.network-manager = {

    networking = {
      networkmanager = {
        enable = true;
        settings = {
          # Use a stable but randomized MAC for each connection
          connection.wifi-cloned-mac-address = "stable";
        };
      };
    };
    };
}
