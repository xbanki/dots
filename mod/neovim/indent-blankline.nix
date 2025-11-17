#   Indent Blankline Configuration `github:lukas-reineke/indent-blankline.nvim`
#
# Configures virtual indentation lines for the editor, which makes code easier
# to read.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  plugins.indent-blankline = {
    settings = {
      scope.enabled = false;
      indent.char = "▏";
    };

    enable = true;
  };
}
