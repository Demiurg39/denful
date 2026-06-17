{
  flake.modules.nixos.delphi = {lib, ...}: {
    services.openssh.settings = {
      PermitRootLogin = lib.mkForce "yes";
    };

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHs7JuXYLla/8vwen9DHAbP1X90J7wJrw2+Cfyf2kbW"
    ];
  };
}
