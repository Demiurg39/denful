{inputs, ...}: {
  flake.modules.nixos.steam = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      gamemode
      gamescope
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      mangohud
    ];

    nixpkgs.overlays = [inputs.millennium.overlays.default];
    fonts.fontDir.enable = true;

    programs.steam = {
      enable = true;
      # package = pkgs.millennium-steam;
      package = pkgs.steam;
      extraPackages = [
        pkgs.keyutils
        pkgs.libgdiplus
        pkgs.vulkan-loader
        pkgs.vulkan-tools
        pkgs.vulkan-validation-layers
        pkgs.libXtst
      ];

      extraCompatPackages = [pkgs.proton-ge-bin pkgs.steamtinkerlaunch];

      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      protontricks.enable = true;
    };

    # Managing proton versions
    environment.systemPackages = [pkgs.protonplus];
  };
}
