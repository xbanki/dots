# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  home.packages = with pkgs; [ figma-agent ];
  systemd.user.services.figma-agent = {
    Unit.Description = "Figma Font Agent";
    Service = {
      ExecStart = "${pkgs.figma-agent}/bin/figma-agent";
      Restart = "on-failure";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
