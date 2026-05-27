{inputs, ...}: {
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      home-manager
      determinate
      secrets
      disko
    ];
  };

  flake.modules.homeManager.system-default = {
    imports = with inputs.self.modules.homeManager; [
      system-minimal
      secrets
    ];
  };
}
