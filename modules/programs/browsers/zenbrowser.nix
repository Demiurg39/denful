{
  inputs,
  lib,
  ...
}: let
in {
  flake.modules.homeManager.zen-browser = {pkgs, ...}: let
    inherit (inputs.self.lib) assoc;
    zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  in {
    home.packages = [
      zen
    ];

    # home.sessionVariables.BROWSER = lib.getExe zen;
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
