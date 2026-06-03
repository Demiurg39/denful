{
  flake.modules.homeManager.cliphist = {pkgs, ...}: {
    home.packages = [pkgs.wl-clipboard-rs];

    services.cliphist = {
      enable = true;
      allowImages = true;
      extraOptions = [
        "-max-dedupe-search"
        "20"
        "-max-items"
        "500"
      ];
    };
  };
}
