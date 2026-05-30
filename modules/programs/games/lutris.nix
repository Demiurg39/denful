{
  flake.modules.homeManager.lutris = {
    osConfig,
    pkgs,
    ...
  }: {
    programs.lutris = {
      enable = true;
      extraPackages = [pkgs.mangohud pkgs.vulkan-tools];
      steamPackage = osConfig.programs.steam.package;
      protonPackages = pkgs.proton-ge-bin;
      winePackages = pkgs.wineWow64Packages.staging;
    };

    environment.systemPackages = [
      pkgs.protonplus
    ];
  };
}
