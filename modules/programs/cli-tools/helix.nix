{
  flake.modules.homeManager.helix = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "base16_transparent";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys = {
          normal = {
            space = {
              w = ":w";
            };
          };
        };
      };
    };
  };
}
