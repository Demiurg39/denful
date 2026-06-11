{
  flake.modules.nixos.usbguard = {
    services.usbguard = {
      enable = true;
      implicitPolicyTarget = "block";
      IPCAllowedGroups = ["wheel"];
      presentControllerPolicy = "allow";
    };
  };
}
