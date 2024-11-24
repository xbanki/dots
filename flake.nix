#   Banki NixOS Developer Environment
#
# Modular NixOS setup that supports multiple targets, namely:
#
#  - Windows — Headless NixOS WSL distribution
#  - Linux   — Custom-built Nix distribution
#  - MacOS   — Nix shell through Nix Darwin
#
# While still shipping many common components I may depend on for development.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for detailsk.
#
#   Version:   N/A
#
#   Since:     N/A

{
  description = "dots - Banki (xbanki) Dotfiles";

  inputs = {};

  outputs = inputs@{ self, nixpkgs, ... }:
  {
    nixosConfigurations = {
      wsl = import ./sys/wsl { inherit inputs; };
    };
  }
}
