{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.dms = {
    imports = [
      inputs.dms.nixosModules.dank-material-shell
      inputs.dms.nixosModules.greeter
    ];

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.dms
    ];

    systemd.user.services.niri-flake-polkit.enable = false;
    programs.dank-material-shell = {
      enable = true;
      greeter.enable = true;
      greeter.compositor.name = "niri";
    };
  };

  flake.modules.homeManager.dms = {
    systemd.user.services.niri-flake-polkit.enable = false;
    programs.dank-material-shell = {
      enable = true;
      settings =
        "${self.inputs.configs}/dms/dank.json"
        |> builtins.readFile
        |> builtins.fromJSON;
      niri.enableSpawn = true;
      niri.includes.enable = true;
      plugins = {dankBatteryAlerts.enable = true;};
    };
  };
}
