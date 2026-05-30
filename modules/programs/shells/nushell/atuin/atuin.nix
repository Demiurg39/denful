{inputs, ...}: {
  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      atuin
    ];

    programs.atuin.enableNushellIntegration = true;
  };
}
