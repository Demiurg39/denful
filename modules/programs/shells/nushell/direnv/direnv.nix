{inputs, ...}: {
  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      direnv
    ];

    programs.direnv.enableNushellIntegration = true;
  };
}
