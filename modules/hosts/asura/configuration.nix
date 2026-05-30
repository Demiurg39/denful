{self, ...}: {
  flake.modules.nixos.asura = {
    imports = with self.modules.nixos; [
      system-desktop
      systemd-boot

      resolved
    ];

    system.stateVersion = "24.11";
  };
}
