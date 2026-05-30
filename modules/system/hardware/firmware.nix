{self, ...}: {
  flake.modules.nixos.firmware = {
    # imports = [
    #   (self.factory.unfree ["linux-firmware" "fwupd"])
    # ];

    services.fwupd.enable = true;
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    nixpkgs.config.allowUnfree = true; # enableAllFirmware depends on this
  };
}
