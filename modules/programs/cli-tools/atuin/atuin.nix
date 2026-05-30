{
  flake.modules.homeManager.atuin = {
    programs.atuin = {
      enable = true;
      settings = {
        sync_address = "https://api.atuin.sh";
        keymap_mode = "vim-insert";
        command_chaining = true;
        secrets_filter = true;
        show_help = false;
        style = "auto";
        auto_sync = true;
      };
    };
  };
}
