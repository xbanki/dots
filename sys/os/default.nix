#   NixOS System Configuration
#
# Customized NixOS distribution. Lightweight and minimal by design.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  inputs,
  ...
}:

let
  system = "x86_64-linux";

in
with inputs;
nixpkgs.lib.nixosSystem {
  inherit system;
}
