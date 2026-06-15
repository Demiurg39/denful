{
  flake.modules.nixos.delphi = {lib, ...}: {
    networking.usePredictableInterfaceNames = lib.mkDefault true;
    networking.interfaces.enp0s6 = {
      mtu = 9000;
      ipv4.addresses = lib.mkDefault [
        {
          address = "10.0.0.126";
          prefixLength = 24;
        }
      ];
    };

    networking.defaultGateway = {
      address = "10.0.0.1";
      interface = "enp0s6";
    };

    networking.nameservers = ["9.9.9.9" "149.112.112.112"];

    networking.networkmanager.enable = lib.mkForce false;
    services.resolved.enable = true;
  };
}
