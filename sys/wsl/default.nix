#   WSL System Configuration
#
# Lightweight Windows development environment, enabling us to escape the hell
# that is Windows instability, spyware and general bloat.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for detailsk.
#
#   Version:   N/A
#
#   Since:     N/A

{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    {
      wsl = {
        wslConf = {
          network.generateResolvConf = false;
          interop.appendWindowsPath = false;
          automount.root = "/mnt";
        };

        enabled = true;
      };
    }
  ];
}
