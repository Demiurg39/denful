{
  flake-file.inputs = {
    zen-browser.url = "github:youwen5/zen-browser-flake";
    # NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };
}
