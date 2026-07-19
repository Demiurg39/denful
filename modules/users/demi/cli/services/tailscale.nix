{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.demi-cli = {config, ...}: {
    imports = [inputs.self.modules.nixos.tailscale];
    services.tailscale.authKeyFile = config.age.secrets.demiTailscaleAuth.path;
    age.secrets.demiTailscaleAuth.rekeyFile = "${self.inputs.secrets}/users/demi/tailscale_key.age";
  };
}
