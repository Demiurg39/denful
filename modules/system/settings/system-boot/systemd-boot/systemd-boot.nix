{
  flake.modules.nixos.systemd-boot = {
    boot.loader = {
      systemd-boot.enable = true;
      # Fix a security hole in place for backwards compatibility. See desc in
      # nixpkgs/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix
      systemd-boot.editor = false;
      systemd-boot.configurationLimit = 3;
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };
  };
}
