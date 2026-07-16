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
          (assoc pkgs.nautilus {
            inode = ["directory"];
          })
          (assoc pkgs.file-roller {
            application = [
              "zip"
              "x-tar"
              "x-gzip"
              "x-compressed-tar"
              "x-bzip2"
              "x-bzip2-compressed-tar"
              "x-bzip"
              "x-bzip-compressed-tar"
              "x-7z-compressed"
              "x-rar"
              "vnd.rar"
              "x-xz"
              "x-xz-compressed-tar"
              "x-zstd"
            ];
          })
        ];
      };
    };
  };
}
