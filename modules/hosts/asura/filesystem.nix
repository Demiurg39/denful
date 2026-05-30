# TODO: move to disko config
{
  flake.modules.nixos.asura = {
    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            name = "ESP";
            start = "1M";
            end = "128M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0022"];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/rootfs" = {
                  mountpoint = "/";
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd"];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
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
      fileSystems = ["/"];
    };

    # # TODO: add impermanence setup
    # fileSystems."/" = {
    #   device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    #   fsType = "btrfs";
    #   options = ["subvol=@" "compress=zstd" "noatime"];
    # };
    #
    # fileSystems."/home" = {
    #   device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    #   fsType = "btrfs";
    #   options = ["subvol=@home" "compress=zstd" "noatime"];
    # };
    #
    # # TODO: fix this, cause its not working
    # # fileSystems."/nix" = {
    # #   device = "/dev/disk/by-uuid/b9eae7f6-9aab-428e-88dc-a9df3dbd72fb";
    # #   fsType = "btrfs";
    # #   options = ["subvol=@nix" "compress=zstd" "noatime"];
    # # };
    #
    # fileSystems."/boot" = {
    #   device = "/dev/disk/by-label/ESP";
    #   fsType = "vfat";
    # };
    #
    # swapDevices = [
    #   {
    #     device = "/var/swapfile";
    #     size = 8192;
    #   }
    # ];
  };
}
