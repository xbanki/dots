# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  xdg.portal.config.hyprland."org.freedesktop.impl.portal.Settings" = [ "darkman" ];
  services.darkman = {
    settings.usegeoclue = true;
    enable = true;
  };
}
