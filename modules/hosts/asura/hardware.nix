{inputs, ...}: {
  flake.modules.nixos.asura = {modulesPath, ...}: {
    imports = with inputs.self.modules.nixos; [
      (modulesPath + "/installer/scan/not-detected.nix")
      (inputs.self.factory.zram {memPercent = 150;})
      cpu-amd
      gpu-amd
      gpu-nvidia-laptop
      audio-pipewire
      bluetooth
      wifi
      ssd
    ];

    hardware.nvidia.prime = {
      amdgpuBusId = "PCI:05:0:0";
      nvidiaBusId = "PCI:01:0:0";
    };

    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "sd_mod"];
    boot.kernelParams = ["acpi_backlight=native" "amd_pstate=active"];
    boot.kernelModules = ["kvm-amd"];
  };
}
