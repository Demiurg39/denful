{lib, ...}: {
  flake.modules.nixos.ssd = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      smartmontools
      nvme-cli
      hdparm
    ];

    # Periodically run fstrim to inform the SSD about unused blocks,
    # maintaining high write performance and balanced cell wear over time.
    services.fstrim.enable = true;

    # Disable default daily Nix garbage collection. Frequent massive deletions
    # of small files drastically accelerate SSD cell degradation (wear out).
    nix.gc.automatic = false;

    boot.kernel.sysctl = {
      # Reduce kernel tendency to swap anonymous memory. Keeping data in RAM
      # longer decreases unnecessary write operations to the SSD/NVMe.
      "vm.swappiness" = lib.mkDefault 10;

      # Increase dirty memory cache lifetimes. The kernel will buffer writes
      # in RAM longer, allowing it to flush data to disk in larger, continuous,
      # and more efficient linear blocks (ideal for SSD controller layout).
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
    };

    # Optimize I/O scheduling for modern solid-state drives.
    # High-speed NVMe drives perform best with "none" (no scheduler overhead).
    # SATA SSDs perform best with "kyber" or "bfq" for multi-tasking fairness.
    services.udev.extraRules = ''
      # NVMe drives
      ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="none"

      # SATA SSDs / eMMC
      ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="kyber"
    '';
  };
}
