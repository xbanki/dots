#   Blink Completion Configuration `github:saghen/blink.cmp`
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ pkgs, lib, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    blink-ripgrep-nvim
  ];

  plugins = {
    blink-ripgrep.enable = true;
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        signature.enabled = true;
        sources = {
          default = [
            "buffer"
            "lsp"
            "path"
            "snippets"
            "ripgrep"
          ];

          providers.ripgrep = {
            module = "blink-ripgrep";
            score_offset = 1;
            name = "Ripgrep";
          };
        };

        keymap = {
          preset = "super-tab";
          "<C-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];

          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];

          "<C-space>" = [
            "show_signature"
            "hide_signature"
            "fallback"
          ];
        };

        completion = {
          accept.auto_brackets.enabled = false;
          trigger.show_in_snippet = false;
          ghost_text.enabled = true;
          documentation = {
            auto_show_delay_ms = 256;
            window.border = "solid";
            auto_show = true;
          };

          menu = {
            border = "solid";
            draw = {
              gap = 1;
              treesitter = [ "lsp" ];
              columns =
                let
                  mkAttrs = lib.nixvim.listToUnkeyedAttrs;

                in
                [
                  (mkAttrs [ "kind_icon" ])
                  (
                    mkAttrs [ "label" ]
                    // {
                      width.fill = true;
                    }
                  )

                  (mkAttrs [ "label_description" ])
                ];
            };
          };
        };

        appearance.kind_icons = {
          TypeParameter = "";
          Constructor = "󰊕";
          EnumMember = "";
          Interface = "󱡠";
          Reference = "";
          Property = "";
          Constant = "";
          Variable = "";
          Function = "󰊕";
          Operator = "";
          Snippet = "󱄽";
          Keyword = "󰻾";
          Folder = "";
          Module = "󰅩";
          Struct = "";
          Method = "";
          Color = "";
          Field = "";
          Event = "";
          Class = "";
          Value = "󰦨";
          Unit = "";
          File = "";
          Enum = "";
          Text = "󰉿";
        };
      };
    };
  };
}
