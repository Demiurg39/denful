{inputs, ...}: {
  flake.modules.nixos.asura = {
    imports = [inputs.self.modules.nixos.usbguard];
    services.usbguard = {};
  };
}
