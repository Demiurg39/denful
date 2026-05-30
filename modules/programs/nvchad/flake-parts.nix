{
  flake-file.inputs = {
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs-stable";
      inputs.nvchad-starter.follows = "nvim-dots";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nvim-dots.url = "github:demiurg39/nvchad";
    nvim-dots.flake = false;
  };
}
