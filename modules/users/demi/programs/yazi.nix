{inputs, ...}: {
  flake.modules.homeManager.demi = {pkgs, ...}: {
    imports = [inputs.self.modules.homeManager.yazi];
    xdg.mimeApps.defaultApplications = inputs.self.lib.assoc pkgs.yazi {"inode" = ["directory"];};
  };
}
