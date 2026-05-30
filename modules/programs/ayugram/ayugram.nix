{inputs, ...}: {
  flake.modules.homeManager.ayugram = {config, ...}: {
    home.packages = [
      inputs.ayugram-desktop.packages.${config.hostPlatform}.ayugram-desktop
    ];
  };
}
