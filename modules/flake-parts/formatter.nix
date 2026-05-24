# formatter: formatting with `nix fmt .` assuming you in flake root
{
  flake-file.formatter = {pkgs, ...}: pkgs.alejandra;

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
