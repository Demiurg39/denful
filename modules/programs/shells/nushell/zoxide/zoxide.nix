{inputs, ...}: {
  flake.modules.homeManager.nushell = {
    imports = with inputs.self.modules.homeManager; [
      zoxide
    ];

    programs.zoxide.enableNushellIntegration = true;
  };
}
