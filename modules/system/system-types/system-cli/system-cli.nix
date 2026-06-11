{inputs, ...}: {
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default

      network-hardening
      tcp-optimization
      cli-tools
      firewall
      firmware
      ssh
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-default
      xdg
    ];
  };
}
