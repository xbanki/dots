# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

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
        # go = [ "golangcilint" ];
        yaml = [ "yamllint" ];
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
          luacheck.cmd = exe luaPackages.luacheck;
          # golangcilint.cmd = exe golangci-lint;
          shellcheck.cmd = exe shellcheck;
          yamllint.cmd = exe yamllint;
          eslint_d.cmd = exe eslint_d;
          deadnix.cmd = exe deadnix;
          pylint.cmd = exe pylint;
          biomejs.cmd = exe biome;
          zsh.cmd = exe zsh;
        };
    };
}
