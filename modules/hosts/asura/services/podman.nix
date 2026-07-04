{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = [inputs.self.modules.nixos.podman];
    hardware.nvidia-container-toolkit.enable = true;
  };
}
