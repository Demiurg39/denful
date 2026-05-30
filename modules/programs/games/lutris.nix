{
  flake.modules.homeManager.lutris = {
    osConfig,
    pkgs,
    ...
  }: {
    programs.lutris = {
      enable = true;
      steamPackage = osConfig.programs.steam.package;
      extraPackages = [pkgs.mangohud pkgs.vulkan-tools];
      protonPackages = [pkgs.proton-ge-bin];
      winePackages = [pkgs.wineWow64Packages.staging];
    };

    home.packages = [
      pkgs.protonplus
    ];
  };
}
