{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    (self.factory.user {
      username = "demi";
      uid = 1000;
      isAdmin = true;
      hasPass = true;
      hasSSH = true;
    })
    {
      nixos.demi = {pkgs, ...}: {
        imports = [self.modules.nixos.kanata];
        users.users.demi.shell = pkgs.nushell;
        i18n.extraLocales = ["ru_RU.UTF-8/UTF-8"];
        console.keyMap = "mod-dh-ansi-us";
      };

      nixos.demi-cli = {
        imports = [self.modules.nixos.tailscale];
      };

      homeManager.demi-cli = {
        imports = with self.modules.homeManager; [
          atuin
          devenv
          direnv
          nvchad
          passwordManager
          zoxide
          helix
        ];
      };
    }
  ];
}
