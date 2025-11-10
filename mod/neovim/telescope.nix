#   Telescope (`github:nvim-telescope/telescope.nvim`) Configuration
#
# Telescope is configured to function as the primary means to interact with
# files in the directory that neovim is opened in.
#
# Neovim's built-in file explorer (netrw) gets disabled in favor of Telescope's
# `github:nvim-telescope/telescope-file-browser.nvim` plugin.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      file-browser = {
        enable = true;
      };
    };
  };
}
