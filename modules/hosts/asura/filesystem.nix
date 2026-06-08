# TODO: move to disko config
{
  config,
  self,
  ...
}: {
  flake.modules.nixos.asura = {
    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-eui.002538dc21a0d33e";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            name = "ESP";
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              settings.allowDiscards = true;
              extraFormatArgs = ["--type luks2" "--pbkdf argon2id"];
              content = {
                type = "btrfs";
                extraArgs = ["-f" "--csum xxhash"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "discard=async"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
    boot.supportedFilesystems = ["btrfs"];

    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
  };
}
