{
  flake.modules.nixos.demi-desktop = {config, ...}: let
    home = config.home-manager.users.demi.home.homeDirectory;
  in {
    services.displayManager.dms-greeter.configHome = home;
  };
}
