# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
    enable = true;
  };

  services.flatpak.enable = true;
}
