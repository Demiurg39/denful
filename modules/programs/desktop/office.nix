{
  flake.modules.homeManager.office = {
    programs.onlyoffice = {
      enable = true;
      settings = {
        UITheme = "theme-contrast-dark";
        editorWindowMode = false;
        maximized = true;
      };
    };
  };
}
