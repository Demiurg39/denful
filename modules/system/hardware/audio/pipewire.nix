{
  flake.modules.nixos.audio-pipewire = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    # make pipewire realtime-capable
    security.rtkit.enable = true;
  };

  flake.modules.homeManager.audio.pipewire = {pkgs, ...}: {
    home.packages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };
}
