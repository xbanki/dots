#   Markview Configuration `github:`OXY2DEV/markview.nvim
#
# Comprehensive Markdown previewer in Neovim.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  plugins.markview = {
    settings.preview = {
      icon_provider = "devicons";
      enable = false;
    };

    enable = true;
  };
}
