{
  flake.modules.nixos.usbguard = {
    services.usbguard = {
      enable = true;
      presentControllerPolicy = "allow";
    };
  };
}
