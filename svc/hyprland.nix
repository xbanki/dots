# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  system,
  inputs,
  pkgs,
  ...
}:

let
  portalPackage = inputs.nixpkgs-hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  package = inputs.nixpkgs-hyprland.packages.${system}.hyprland;

in
{
  xdg.portal = {
    config.hyprland.default = [
      "hyprland"
      "gtk"
    ];

    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];

    enable = true;
  };
  programs.hyprland = {
    inherit portalPackage package;
    withUWSM = true;
    enable = true;
  };
}
