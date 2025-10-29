#   Neovim configuration
#
# Configures Neovim through Nixvim.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.


{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
  };
}
