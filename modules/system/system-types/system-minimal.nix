{
  inputs,
  self,
  lib,
  ...
}: {
  flake.modules.nixos.system-minimal = {
    environment.variables.FLAKE = "${self}";

    nix = let
      filteredInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in {
      # Pin the registry to avoid downloading/evaling
      # a new nixpkgs version every time
      registry = lib.mapAttrs (_: v: {flake = v;}) filteredInputs;
      nixPath = lib.mapAttrsToList (n: v: "${n}=${v}") filteredInputs;

      gc.automatic = true;

      settings = {
        auto-optimise-store = true;

        # Use binary cache, its not gentoo
        builders-use-substitutes = true;

        substituters = [
          # High priority since it's almost always used
          "https://cache.nixos.org?priority=10"
          "https://nix-community.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        # Enable flakes support
        experimental-features = [
          "pipe-operators"
          "nix-command"
          "flakes"
        ];

        download-buffer-size = 1024 * 1024 * 1024;

        warn-dirty = false;
        keep-outputs = true;
        http2 = true;

        trusted-users = ["root" "@wheel"];
      };
    };

    time.timeZone = inputs.self.const.timezone;
  };
}
