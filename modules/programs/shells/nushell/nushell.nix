{inputs, ...}: {
  flake.modules.nixos.nushell = {pkgs, ...}: {
    home-manager.sharedModules = [inputs.self.modules.homeManager.nushell];
    environment.shells = [pkgs.nushell];
  };

  flake.modules.homeManager.nushell = {
    config,
    lib,
    ...
  }: let
    inline = lib.hm.nushell.mkNushellInline;
  in {
    imports = [inputs.self.modules.homeManager.carapace];

    programs.nushell = {
      enable = true;
      settings = {
        show_banner = false;
        completions.external = {
          enable = true;
          max_results = 200;
        };
      };
      shellAliases = {
        grep = "grep --color=auto";
        diff = "diff --color";
        lla = "ls -la";
        ll = "ls -l";
        cl = "clear";
        cp = "cp -v";
        mv = "mv -v";
        rm = "rm -v";
      };
      environmentVariables = {
        SUDO_PROMPT = inline ''$"(ansi blue)%u(ansi reset) password ->"'';
        XDG_CACHE_HOME = config.xdg.cacheHome;
      };
    };
  };
}
