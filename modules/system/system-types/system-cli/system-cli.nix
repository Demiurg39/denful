{inputs, ...}: {
  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default
      cli-tools
      firmware
      ssh
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-default
    ];
  };
}
