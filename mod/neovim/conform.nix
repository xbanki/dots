#   Conform Configuration `github:stevearc/conform.nvim`
#
# Configures automatic formatting of buffer content before writing.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  extraPackages = with pkgs; [
    nixfmt-rfc-style
  ];

  plugins.conform-nvim = {
    enable = true;
    settings = {
      notify_no_formatters = false;
      notify_on_error = true;
      format_on_save = {
        stop_after_first = true;
        lsp_format = "fallback";
        timeout_ms = 512;
      };

      formatters_by_ft =
        let
          javascript = prettier ++ [ "biome" ];
          prettier = [
            "prettierd"
            "prettier"
          ];

        in
        {
          python =
            lib.nixvim.listToUnkeyedAttrs [
              "isort"
              "black"
            ]
            // {
              stop_after_first = false;
            };

          go =
            lib.nixvim.listToUnkeyedAttrs [
              "golines"
              "gofmt"
            ]
            // {
              stop_after_first = false;
            };

          typescriptreact = javascript;
          javascriptreact = javascript;
          typescript = javascript;
          javascript = javascript;
          json5 = javascript;
          jsonc = javascript;
          json = javascript;
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
        };
    };
  };
}
