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
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHs7JuXYLla/8vwen9DHAbP1X90J7wJrw2+Cfyf2kbW"
          ];
        };

        age.secrets.demiHashedPassword.rekeyFile = "${self.inputs.secrets}/demi-hashed-password.age";

        i18n = {
          defaultLocale = lib.mkDefault "en_US.UTF-8";
          supportedLocales = ["ru_RU.UTF-8/UTF-8"];
        };

        console.keyMap = "mod-dh-ansi-us";
      };

      homeManager.demi = {
        imports = with self.modules.homeManager; [
          system-desktop

          spotify

          passwordManager
          nushell
          atuin
          direnv
          yazi
          zoxide
        ];
        home.stateVersion = "24.11";
        home.preferXdgDirectories = true;
      };
    }
  ];
}
