#   NixOS System Configuration
#
# Customized NixOS distribution. Lightweight and minimal by design.
#
#   Copyright: Banki <development@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  version,
  inputs,
  ...
}:

let
  system = "x86_64-linux";
  specialArgs = { inherit system; };

in
with inputs;
nixpkgs.lib.nixosSystem {
  inherit specialArgs system;
  modules = [
    ./boot.nix
    ./hardware.nix
    {
      system.stateVersion = version;
      nixpkgs.config = {
        allowUnfreePredicate = _: true;
        allowUnfree = true;
      };
    }
  ];
}
