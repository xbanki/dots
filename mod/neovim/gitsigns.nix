#   Gitsigns Configuration `github:lewis6991/gitsigns.nvim`
#
# Configures gutter line git status characters, and an in-editor blame.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  plugins.gitsigns = {
    settings.current_line_blame = true;
    enable = true;
  };
}
