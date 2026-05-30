{inputs', ...}: let
  inherit (inputs'.self.lib) assoc;
  zen = inputs'.zen-browser.packages.default;
in {
  flake.modules.homeManager.zen-browser = {
    home.packages = [
      zen
    ];

    xdg.mimeApps.defaultApplications = assoc zen {
      "application" = [
        "json"
        "x-extension-htm"
        "x-extension-html"
        "x-extension-shtml"
        "x-extension-xht"
        "x-extension-xhtml"
        "xhtml+xml"
      ];
      "x-scheme-handler" = [
        "about"
        "chrome"
        "ftp"
        "http"
        "https"
        "unknown"
      ];
    };
  };
}
