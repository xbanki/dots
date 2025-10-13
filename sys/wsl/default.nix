#   WSL System Configuration
#
# Lightweight Windows development environment, enabling us to escape the hell
# that is Windows instability, spyware and general bloat.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ version, inputs, home, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = with inputs; [
    nixpkgs-wsl.nixosModules.default
    nixpkgs-home-manager.nixosModules.home-manager
    {
      home-manager = home { };
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
