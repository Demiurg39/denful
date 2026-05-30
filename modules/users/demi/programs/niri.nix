{inputs, ...}: {
  flake.modules.homeManager.demi = {
    imports = [inputs.self.modules.homeManager.niri];
    programs.niri.settings.input.keyboard.xkb.variant = "colemak_dh,";
  };
}
