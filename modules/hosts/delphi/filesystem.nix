{
  flake.modules.nixos.delphi = {
    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/wwn-0x60f10ca0b374408987b7d7acac051c87";
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
          rootfs = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
