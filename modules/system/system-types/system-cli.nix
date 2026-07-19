{inputs, ...}: {
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default

      network-hardening
      tcp-optimization
      firewall
      firmware
    ];
  };
}
