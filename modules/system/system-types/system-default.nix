{inputs, ...}: {
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      home-manager
      determinate
      nix-index
      secrets
      disko
      nh
    ];
  };
}
