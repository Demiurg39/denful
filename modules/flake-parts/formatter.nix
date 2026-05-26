# formatter: formatting with `nix fmt .` assuming you in flake root
{
  flake-file.formatter = {pkgs, ...}: pkgs.alejandra;

  flake-file.write-hooks = [
    {
      index = 10;
      program = pkgs:
        pkgs.writeShellApplication {
          name = "flake-format";
          text = ''${pkgs.lib.getExe pkgs.nix} fmt .'';
        };
    }
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
