#   Linter Configuration `github:mfussenegger/nvim-lint`
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  plugins.lint =
    let
      shell = [ "shellcheck" ];
      html = [ "biomejs" ];
      css = [ "biomejs" ];
      javascript = [
        "eslint_d"
        "eslint"
      ];

    in
    {
      enable = true;
      lintersByFt = {
        nix = [
          "deadnix"
          "nix"
        ];

        typescriptreact = javascript;
        javascriptreact = javascript;
        typescript = javascript;
        javascript = javascript;
        go = [ "golangcilint" ];
        yaml = [ "yamllint" ];
        json = [ "jsonlint" ];
        python = [ "pylint" ];
        lua = [ "luacheck" ];
        vue = javascript;
        zsh = [ "zsh" ];
        bash = shell;
        html = html;
        sh = shell;
        less = css;
        sass = css;
        scss = css;
        css = css;
      };

      linters =
        let
          exe = lib.getExe;

        in
        with pkgs;
        {
          jsonlint.cmd = exe nodePackages.jsonlint;
          eslint_d.cmd = exe nodePackages.eslint_d;
          luacheck.cmd = exe luaPackages.luacheck;
          golangcilint.cmd = exe golangci-lint;
          shellcheck.cmd = exe shellcheck;
          yamllint.cmd = exe yamllint;
          deadnix.cmd = exe deadnix;
          pylint.cmd = exe pylint;
          biomejs.cmd = exe biome;
          zsh.cmd = exe zsh;
        };
    };
}
