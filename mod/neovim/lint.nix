#   Linter Configuration `github:mfussenegger/nvim-lint`
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  plugins.lint = let
    shell = ["shellcheck"];
    html  = ["biomejs"];
    css   = ["biomejs"];
    javascript = [
      "eslint"
      "eslint_d"
    ];

  in  {
    enable = true;
    lintersByFt = {
      nix = [
        "deadnix"
        "nix"
      ];

      go              = ["golangcilint"];
      yaml            = ["yamllint"];
      json            = ["jsonlint"];
      lua             = ["luacheck"];
      python          = ["pylint"];
      typescriptreact = javascript;
      javascriptreact = javascript;
      typescript      = javascript;
      javascript      = javascript;
      vue             = javascript;
      zsh             = ["zsh"];
      bash            = shell;
      sh              = shell;
      html            = html;
      less            = css;
      sass            = css;
      scss            = css;
      css             = css;
    };

    linters = let
      exe = lib.getExe;

    in with pkgs; {
      jsonlint.cmd     = exe nodePackages.jsonlint;
      eslint_d.cmd     = exe nodePackages.eslint_d;
      luacheck.cmd     = exe luaPackages.luacheck;
      golangcilint.cmd = exe golangci-lint;
      shellcheck.cmd   = exe shellcheck;
      yamllint.cmd     = exe yamllint;
      deadnix.cmd      = exe deadnix;
      pylint.cmd       = exe pylint;
      biomejs.cmd      = exe biome;
      zsh.cmd          = exe zsh;
    };
  };
}
