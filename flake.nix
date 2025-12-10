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
#              See LICENSE for details.

{
  description = "dots - Banki (xbanki) Dotfiles";
  inputs = {
    nixpkgs-home-manager.url = "github:nix-community/home-manager";
    nixpkgs-nixvim.url = "github:nix-community/nixvim";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-sops.url = "github:Mic92/sops-nix";
    nixpkgs-wsl.url = "github:nix-community/nixos-wsl/main";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      props = builtins.fromTOML (builtins.readFile ./config.toml);
      version = "25.05";

    in
    {
      nixosConfigurations = {
        wsl = import ./sys/wsl { inherit version inputs props; };
        os = import ./sys/os { inherit version inputs props; };
      };
    };
}
