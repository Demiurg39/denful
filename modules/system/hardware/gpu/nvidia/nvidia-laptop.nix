{inputs, ...}: {
  flake.modules.nixos.gpu-nvidia-laptop = {
    imports = [inputs.self.modules.nixos.gpu-nvidia];

    boot.extraModprobeConfig = ''
      options nvidia "NVreg_DynamicPowerManagement=0x02" # finegrained
      options nvidia "NVreg_PreserveVideoMemoryAllocations=1"
    '';

    hardware.nvidia = {
      powerManagement.finegrained = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };

      nvidiaPersistenced = false;
    };

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto"
      ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
      ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
    '';
  };
}
