{
  flake.modules.nixos.demi = {config, ...}: let
    home = config.home-manager.users.demi.home.homeDirectory;
  in {
    services.displayManager.dms-greeter.configHome = home;
  };
}
