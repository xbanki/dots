# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  version,
  inputs,
  props,
  ...
}:

let
  system = "aarch64-darwin";
  specialArgs = {
    inherit
      version
      inputs
      system
      props
      ;
  };

in
with inputs;
nixpkgs-nix-darwin.lib.darwinSystem {
  inherit specialArgs system;
  modules = [
    ./home.nix
    ./../../home.nix
    nixpkgs-determinate.darwinModules.default
    nixpkgs-home-manager.darwinModules.home-manager
    {
      security.pam.services.sudo_local.touchIdAuth = true;
      determinateNix.enable = true;
      system.stateVersion = 7;
    }
  ];
}
