let
  genericPackages = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      home-manager
      lazygit
      p7zip
      unar
      wget
      git
    ];
  };
in {
  flake.modules.nixos.cli-tools = {
    imports = [genericPackages];
  };
}
