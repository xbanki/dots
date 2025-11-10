#   Neovim Keymaps
#
# Configures global keymaps, and a few extensions.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  globals.mapleader = " ";
  keymaps = [
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader><space>";
    }
  ];
}
