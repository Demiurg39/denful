{inputs, ...}: {
  flake.modules.homeManager.nvchad = {pkgs, ...}: {
    imports = [inputs.nix4nvchad.homeManagerModule];

    programs.nvchad = {
      enable = true;
      extraPackages = with pkgs; [
        gdb
        mermaid-cli
        alejandra
        asm-lsp
        asmfmt
        nixd
        nodejs
        clang-tools
        ghostscript
        fd
        lazygit
        ripgrep
        rustc
        tectonic
      ];
      hm-activation = false;
      backup = false;
    };
  };
}
