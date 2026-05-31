{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    (self.factory.user "demi" true)
    {
      nixos.demi = {
        config,
        pkgs,
        ...
      }: {
        imports = with self.modules.nixos; [
          kanata
        ];
        users.users.demi = {
          hashedPasswordFile = config.age.secrets.demiHashedPassword.path;
          shell = pkgs.nushell;
        };

        age.secrets.demiHashedPassword.rekeyFile = "${self.inputs.secrets}/demi-hashed-password.age";

        i18n = {
          defaultLocale = lib.mkDefault "en_US.UTF-8";
          extraLocales = ["ru_RU.UTF-8/UTF-8"];
        };

        console.keyMap = "mod-dh-ansi-us";
      };

      homeManager.demi = {
        imports = with self.modules.homeManager; [
          system-desktop

          passwordManager
          nushell
          atuin
          direnv
          zoxide
        ];
        home.stateVersion = "24.11";
        home.preferXdgDirectories = true;
      };
    }
  ];
}
