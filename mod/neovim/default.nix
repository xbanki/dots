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
    defaultEditor = true;
    vimdiffAlias = true;
    enable = true;
    imports = [
      ./telescope.nix
      ./keymaps.nix
    ];

    extraPackages = with pkgs; [
      ripgrep
    ];

    plugins = {
      web-devicons.enable = true;
    };
  };
}
