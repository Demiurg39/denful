{
  flake.modules.nixos.amd-cpu = {
    hardware.cpu.amd.updateMicrocode = true;
  };
}
