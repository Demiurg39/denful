{
  config.flake.factory.zram = {
    memPercent ? 50,
    writeBackDev ? null,
    algo ? "zstd",
  }: {
    nixos.zram = {
      zramSwap = {
        enable = true;
        priority = 999;
        swapDevices = 1;
        algorithm = algo;
        memoryPercent = memPercent;
        writeBackDevice = writeBackDev;
      };

      boot.kernel.sysctl.vm.swappiness = 180;
    };
  };
}
