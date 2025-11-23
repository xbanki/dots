#   Tiny Inline Diagnostic Configuration
#   `github:rachartier/tiny-inline-diagnostic.nvim`
#
# Simple & customized inline diagnostics rendering plugin. Configures Vim's
# internal diagnostic icons, which are shown in the gutter.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  plugins.tiny-inline-diagnostic = {
    enable = true;
    luaConfig.content = ''
      local config = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
          },
        },

        virtual_text = false,
      }

      vim.diagnostic.config(config)
    '';

    settings = {
      preset = "simple";
      options = {
        show_diags_only_under_cursor = true;
        show_all_diags_on_cursorline = true;
        add_messages.display_count = true;
        use_icons_from_diagnostic = true;
        break_line.enabled = true;
        multilines = {
          always_show = true;
          enabled = true;
        };
      };
    };
  };
}
