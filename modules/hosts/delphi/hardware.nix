{inputs, ...}: {
  flake.modules.nixos.delphi = {modulesPath, ...}: {
    imports = with inputs.self.modules.nixos; [
      (modulesPath + "/profiles/qemu-guest.nix")
      ssd
    ];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "virtio_net"
      "usbhid"
    ];

    boot.kernelModules = ["virtio_net"];
    boot.kernelParams = ["console=tty1" "console=ttyS0"];
  };
}
