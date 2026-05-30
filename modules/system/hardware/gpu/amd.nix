{lib, ...}: {
  flake.modules.nixos.gpu.amd = {
    boot.initrd.kernelModules = ["amdgpu"];
    services.xserver.videoDrivers = lib.mkBefore ["amdgpu"];

    # graphics drivers / HW accel
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
  };
}
