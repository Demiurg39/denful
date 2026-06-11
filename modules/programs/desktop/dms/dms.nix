{
  inputs,
  self,
  ...
}: {
  flake.modules.nixos.dms = {
    home-manager.sharedModules = [inputs.self.modules.homeManager.dms];

    programs.dms-shell = {
      enable = true;
      systemd.enable = true;
      systemd.restartIfChanged = true;
    };
  };

  flake.modules.homeManager.dms = {
    imports = [inputs.dms.homeModules.dank-material-shell];
    programs.dank-material-shell = {
      enable = true;
      settings =
        "${self.inputs.configs}/dms/dank.json"
        |> builtins.readFile
        |> builtins.fromJSON;
    };
  };
}
