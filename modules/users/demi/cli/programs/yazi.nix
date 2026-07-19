{inputs, ...}: {
  flake.modules.homeManager.demi = {pkgs, ...}: {
    # NOTE: cause problem with file picking in browser and other apps.
    # imports = [inputs.self.modules.homeManager.yazi];
    # xdg.mimeApps.defaultApplications = inputs.self.lib.assoc pkgs.yazi {"inode" = ["directory"];};
  };
}
