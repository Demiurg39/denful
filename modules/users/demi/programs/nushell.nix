{
  flake.modules.homeManager.demi = {
    programs.nushell = {
      enable = true;
      settings = {
        edit_mode = "vi";
        buffer_editor = "nvim";
      };

      shellAliases = {
        # lgit = "lazygit";
        # stl = "steamtinkerlaunch";
        v = "nvim";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
