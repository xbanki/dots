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
#   Copyright: Banki <development@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  description = "dots - Banki (xbanki) Dotfiles";
  inputs = {
    nixpkgs-hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/Hyprland/a0136d8c04687bb36eb8a28eb9d1ff92aea99704";
    };

    nixpkgs-hyprland-plugins = {
      inputs.hyprland.follows = "nixpkgs-hyprland";
      url = "github:hyprwm/hyprland-plugins/3aa21f2e0ca72412f1b434c3126f8f1fec3c716c";
    };

    nixpgs-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wsl = {
      url = "github:nix-community/nixos-wsl/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs-nixvim.url = "github:nix-community/nixvim";
    nixpkgs-sops.url = "github:Mic92/sops-nix";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      props = builtins.fromTOML (builtins.readFile ./config.toml);
      version = "26.05";

    in
    {
      nixosConfigurations = {
        wsl = import ./sys/wsl { inherit version inputs props; };
        os = import ./sys/os { inherit version inputs props; };
      };

      darwinConfigurations.macos = import ./sys/macos { inherit version inputs props; };
    };
}
