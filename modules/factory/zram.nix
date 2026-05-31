{
  config.flake.factory.zram = {
    memPercent ? 50,
    writebackDev ? null,
    algo ? "zstd",
  }: {
    zramSwap = {
      enable = true;
      priority = 999;
      swapDevices = 1;
      algorithm = algo;
      memoryPercent = memPercent;
      writebackDevice = writebackDev;
    };

    boot.kernel.sysctl."vm.swappiness" = 180;
  };
}
