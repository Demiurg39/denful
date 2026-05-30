{inputs, ...}: {
  flake.modules.homeManager.demi = {pkgs, ...}: {
    imports = [inputs.self.modules.homeManager.yazi];
    xdg.mimeApps.defaultApplicatios = inputs.self.lib.assoc pkgs.yazi {"inode" = ["directory"];};
  };
}
