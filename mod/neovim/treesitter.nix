#   Treesitter Configuration `github:nvim-treesitter/nvim-treesitter`
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, ... }:

{
  plugins = {
    treesitter-context.enable = true;
    treesitter = {
      enable = true;
      settings = {
        incremental_selection = {
          enable = true;
        };

        grammarPacswapkages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
        textobjects.enable = true;
        highlight.enable = true;
        nixvimInjections = true;
        indent.enable = true;
      };
    };

    treesitter-textobjects = {
      enable = true;
      select = {
        lookahead = true;
        enable = true;
      };
    };
  };
}
