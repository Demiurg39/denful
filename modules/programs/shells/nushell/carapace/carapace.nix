{inputs, ...}: {
  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      carapace
    ];

    programs.carapace.enableNushellIntegration = true;
  };
}
