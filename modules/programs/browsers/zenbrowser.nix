{inputs', ...}: {
  flake.modules.homeManager.zen-browser = {
    home.packages = [
      inputs'.zen-browser.packages.default
    ];
  };
}
