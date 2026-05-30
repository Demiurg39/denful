{
  flake.modules.nixos.gpu.nvidia = {
    config,
    pkgs,
    ...
  }: let
    nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only

      export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH

      exec "$@"
    '';
  in {
    services.xserver.videoDrivers = ["nvidia"];
    user.extraGroups = ["video"];
    boot.kernelModules = ["nvidia_uvm"];
    boot.blacklistedKernelModules = ["nouveau"];
    environment.systemPackages = [nvidia-offload];

    hardware = {
      graphics.enable = true;
      graphics.extraPackages = [pkgs.libva-vdpau-driver];

      nvidia = {
        modesetting.enable = true;

        # See NixOS/nixos-hardware#348
        powerManagement.enable = true;
        open = true;

        # Select the driver version for specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.production;
      };
    };
  };
}
