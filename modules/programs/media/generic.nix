{
  inputs,
  lib,
  ...
}: let
  inherit (inputs.self.lib) assoc;
in {
  flake.modules.homeManager.media-tools = {pkgs, ...}: {
    home.packages = with pkgs; [
      loupe
      amberol
      nautilus
      file-roller
    ];

    xdg = {
      mimeApps = {
        enable = true;
        defaultApplications = lib.mkMerge [
          (assoc pkgs.loupe {
            image = ["png" "avif" "svg" "jpeg" "jpg" "gif"];
          })
          (assoc pkgs.amberol {
            audio = ["mp3" "flac" "wav" "aac"];
          })
        ];
      };
    };
  };
}
