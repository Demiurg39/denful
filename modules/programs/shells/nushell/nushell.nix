{inputs, ...}: {
  flake.modules.nixos.nushell = {pkgs, ...}: {
    home-manager.sharedModules = [inputs.self.modules.homeManager.nushell];

    environment.shells = [pkgs.nushell];
    environment.systemPackages = with pkgs; [
      bash
    ];
  };

  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      carapace
    ];

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
        cl = "clear";
        grep = "grep --color=auto";
        lgit = "lazygit";
        mv = "mv -v";
        rm = "rm -v";
        diff = "diff --color";
        stl = "steamtinkerlaunch";
        ll = "ls -l";
        # TODO: move to nvim module
        # v = "nvim";
        # vi = "nvim";
        # vim = "nvim";
      };
      environmentVariables = {
        SUDO_PROMPT = ''$"(ansi blue)%u(ansi reset) password -> "'';
        XDG_CACHE_HOME = ''$nu.cache-dir | path dirname'';
      };
    };
  };
}
