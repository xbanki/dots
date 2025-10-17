#   WSL System Configuration
#
# Lightweight Windows development environment, enabling us to escape the hell
# that is Windows instability, spyware and general bloat.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ version, inputs, config, ... }:
let
  home = import ./../../home.nix { inherit version config lib; };
  lib  = inputs.nixpkgs.lib;

in lib.nixosSystem {
  system = "x86_64-linux";
  modules = with inputs; [
    home
    nixpkgs-wsl.nixosModules.default
    nixpkgs-home-manager.nixosModules.home-manager
    {
      system.stateVersion = version;
      wsl = {
        wslConf = {
          interop.appendWindowsPath = false;
          automount.root = "/mnt";
        };

        enable = true;
      };
    }
  ];
}
