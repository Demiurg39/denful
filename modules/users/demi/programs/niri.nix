{
  flake.modules.nixos.demi = {
    home-manager.users.demi = {
      programs.niri.settings.input.keyboard.xkb.variant = "colemak_dh,";
    };
  };
}
