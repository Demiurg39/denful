{
  flake.modules.nixos.passwordManager = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # FIX: has unfree license, add unfree handling
      keyguard
      rbw
    ];
  };
}
