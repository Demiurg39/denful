{inputs, ...}: {
  flake.modules.homeManager.nvchad = {pkgs, ...}: {
    imports = [inputs.nix4nvchad.homeManagerModule];

    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [
        alejandra
        asm-lsp
        asmfmt
        cargo
        clang-tools
        gdb
        ghostscript
        fd
        lazygit
        mermaid-cli
        nixd
        nodejs
        ripgrep
        rustc
        tectonic
        unrar
        unzip
      ];
      hm-activation = false;
      backup = false;
    };
  };
}
