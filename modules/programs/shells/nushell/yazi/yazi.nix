{inputs, ...}: {
  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      yazi
    ];

    programs.yazi.enableNushellIntegration = true;
  };
}
