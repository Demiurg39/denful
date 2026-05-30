{self, ...}: {
  flake.modules.nixos.kanata = {
    services.kanata = {
      enable = true;
      keyboards.default = {
        configFile = "${self.inputs.configs}/kanata/main.kbd";
      };
    };
  };
}
