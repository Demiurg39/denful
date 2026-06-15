{self, ...}: {
  flake.modules.nixos.delphi = {
    imports = with self.modules.nixos; [
      system-cli
      systemd-boot

      resolved
    ];

    system.stateVersion = "26.11";
  };
}
