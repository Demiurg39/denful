{
  flake.modules.homeManager.passwordManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      # FIX: has unfree license, add unfree handling
      keyguard
      rbw
    ];
  };
}
