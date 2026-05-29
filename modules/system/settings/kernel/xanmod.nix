{
  flake.modules.nixos.kernel.xanmod = {pkgs, ...}: {
    boot.kernelPackages = pkgs.linuxPackages.xanmod;
  };
}
