{
  flake-file.inputs = {
    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
