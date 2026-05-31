{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.secrets = {config, ...}: {
    imports = [
      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
    ];

    age.rekey = {
      storageMode = "local";
      localStorageDir = "${self.inputs.secrets}/rekeyed/${config.networking.hostName}";
      masterIdentities = [
        {
          identity = "${self.inputs.secrets}/master-key.age";
          pubkey = "age1dphk4m8sr6dhm6amwlvyg3tg0yxfgy9w0meywu8u9205gvx4c5eskaa6nc";
        }
      ];
    };
  };

  flake.modules.homeManager.secrets = {
    imports = [inputs.agenix.homeManagerModules.default];
  };
}
