#   Neovim configuration
#
# Configures Neovim through Nixvim.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  programs.nixvim = {
    defaultEditor = true;
    vimdiffAlias = true;
    enable = true;
    imports = [
      ./indent-blankline.nix
      ./telescope.nix
      ./keymaps.nix
    ];

    # Enables plugins which do not require explicit configuration, or whose
    # default configuration fits the configuration needs.
    plugins = {
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
    };
  };
}
