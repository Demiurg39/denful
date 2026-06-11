{
  inputs,
  lib,
  ...
}: let
  inherit (inputs.self.lib) assoc;
  def_url = "https://4get.ca";
  start_page = def_url;
in {
  flake.modules.homeManager.qutebrowser = {pkgs, ...}: {
    programs.qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser.override {enableWideVine = true;};
      settings = {
        auto_save.session = true;
        backend = "webengine";
        colors.webpage.darkmode = {
          algorithm = "lightness-cielab";
          enabled = true;
          policy.images = "smart-simple";
          policy.page = "smart";
        };
        colors.webpage.preferred_color_scheme = "light";
        completion.height = "40%";
        content.autoplay = false;
        content.blocking.enabled = true;
        content.blocking.method = "adblock";
        content.cache.size = 52428800; # 50MiBs
        content.canvas_reading = false;
        content.cookies.accept = "all"; # Might break some sites such as Gmail
        content.cookies.store = true;
        content.default_encoding = "utf-8";
        content.geolocation = false;
        content.headers.do_not_track = true;
        content.pdfjs = true;
        content.webgl = false;
        content.webrtc_ip_handling_policy = "default-public-interface-only";
        downloads.remove_finished = 3000;
        fonts.default_family = "Inter";
        fonts.default_size = "11pt";
        hints.chars = "arstgmneio";
        qt.args = ["process-per-site" "enable-gpu-rasterization"];
        session.default_name = "default";
        session.lazy_restore = true;
        spellcheck.languages = ["en-US" "ru-RU"];
        tabs.indicator.width = 0; # no tab indicators
        tabs.mousewheel_switching = false;
        tabs.show = "multiple";
        url.default_page = def_url;
        url.start_pages = start_page;
        window.hide_decoration = true;
        window.transparent = true;
      };
      perDomainSettings = {
        "file://*" = {colors.webpage.darkmode.enabled = false;};
      };
      searchEngines = {
        DEFAULT = "${def_url}/web?s={}";
        "!vid" = "${def_url}/videos?s={}";
        "!img" = "${def_url}/images?s={}";
        "!yt" = "https://youtube.com/results?search_query={}";
        "!gh" = "https://github.com/search?q={}";
        "!pkgs" = "https://search.nixos.org/packages?query={}";
        "!opts" = "https://search.xn--nschtos-n2a.de/?query={}";
        "!nw" = "https://wiki.nixos.org/w/index.php?search={}";
        "!nwu" = "https://nixos.wiki/index.php?search={}";
        "!nf" = "https://noogle.dev/q?term={}";
        "!ddg" = "https://duckduckgo.com/?q={}";
        "!tl" = "https://www.reverso.net/text-translation#sl=rus&tl=eng&text={}";
      };
      greasemonkey = [];
      keyBindings = {
        normal = {
          ",d" = "config-cycle colors.webpage.darkmode.enabled true false";
        };
      };
    };

    xdg.mimeApps.defaultApplications = assoc pkgs.qutebrowser {
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

    home.sessionVariables.BROWSER = lib.getExe pkgs.qutebrowser;
  };
}
