{inputs, ...}: {
  flake.modules.homeManager.nushell = {pkgs, ...}: {
    imports = [inputs.self.modules.homeManager.carapace];

    home.packages = with pkgs; [
      fish
      zsh
    ];

    programs.carapace.enableNushellIntegration = true;
    programs.nushell.environmentVariables.CARAPACE_BRIDGES = "zsh,fish";
  };
}
