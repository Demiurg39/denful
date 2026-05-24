# nix-auto-follow: detects duplicate inputs and injects follows for them.
{inputs, ...}: {
  imports = [inputs.flake-file.flakeModules.nix-auto-follow];
}
