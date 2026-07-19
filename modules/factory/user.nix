{
  inputs,
  self,
  ...
}: {
  config.flake.factory.user = {
    username,
    uid,
    isAdmin ? false,
    hasPass ? false,
    hasSSH ? false,
  }: let
    ssh_pubkey =
      if hasSSH
      then (builtins.readFile "${inputs.secrets}/pub/${username}/id_ed25519.pub")
      else null;
  in {
    # collector for user feature additions
    nixos."${username}" = {};
    homeManager."${username}" = {};

    ### minimal
    nixos."${username}-minimal" = {
      config,
      lib,
      ...
    }: {
      imports = with self.modules.nixos; [
        self.modules.nixos."${username}"
        ssh
      ];

      age.secrets."${username}.pass_hashed" = lib.mkIf hasPass {
        rekeyFile = "${self.inputs.secrets}/users/${username}/pass_hashed.age";
      };

      users.users."${username}" = {
        inherit uid;
        home = "/home/${username}";
        hashedPasswordFile = lib.mkIf hasPass config.age.secrets."${username}.pass_hashed".path;
        isNormalUser = true;
        extraGroups = lib.optionals isAdmin ["wheel"];
      };

      i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
      home-manager.users."${username}" = {
        imports = [self.modules.homeManager."${username}-minimal"];
      };
    };
    homeManager."${username}-minimal" = {
      imports = [self.modules.homeManager."${username}"];

      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.preferXdgDirectories = true;
      home.stateVersion = "24.11";
    };

    ### default
    nixos."${username}-default" = {
      imports = [self.modules.nixos."${username}-minimal"];
      home-manager.users."${username}" = {
        imports = [self.modules.homeManager."${username}-default"];
      };
    };
    homeManager."${username}-default" = {lib, ...}: {
      imports = with inputs.self.modules.homeManager; [
        secrets
      ];

      age.rekey = lib.mkIf hasSSH {
        hostPubkey = ssh_pubkey;
      };
    };
    homeManager."${username}-default-standalone" = {
      imports = [
        self.modules.homeManager."${username}-minimal"
        self.modules.homeManager."${username}-default"
      ];
    };

    ### cli
    nixos."${username}-cli" = {
      config,
      lib,
      ...
    }: {
      imports = with self.modules.nixos; [
        self.modules.nixos."${username}-default"
        cli-tools
      ];
      home-manager.users."${username}" = {
        imports = [self.modules.homeManager."${username}-cli"];
      };
      users.users."${username}" = {
        openssh.authorizedKeys.keys = lib.optionals hasSSH [ssh_pubkey];
      };

      age.secrets."${username}.ssh_key" = lib.mkIf hasSSH {
        rekeyFile = "${inputs.secrets}/users/${username}/ssh_key.age";
        path = "/home/${username}/.ssh-key/id_ed25519";
        mode = "600";
        owner = "${username}";
      };
    };
    homeManager."${username}-cli" = {
      config,
      lib,
      ...
    }: {
      imports = with inputs.self.modules.homeManager; [
        xdg
      ];

      home.file = lib.mkIf hasSSH {
        ".ssh/id_ed25519" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.ssh-key/id_ed25519";
          force = true;
        };
      };
    };
    homeManager."${username}-cli-standalone" = {
      imports = [
        self.modules.homeManager."${username}-default"
        self.modules.homeManager."${username}-cli"
      ];
    };

    ### desktop
    nixos."${username}-desktop" = {
      imports = [self.modules.nixos."${username}-cli"];
      home-manager.users."${username}" = {
        imports = [self.modules.homeManager."${username}-desktop"];
      };
    };
    homeManager."${username}-desktop" = {
      imports = with inputs.self.modules.homeManager; [
        media-tools
        office
        mpv
      ];
    };
    homeManager."${username}-desktop-standalone" = {
      imports = [
        self.modules.homeManager."${username}-cli"
        self.modules.homeManager."${username}-desktop"
      ];
    };
  };
}
