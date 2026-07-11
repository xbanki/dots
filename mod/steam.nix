# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud
  ];

  programs = {
    gamescope.enable = true;
    gamemode.enable = true;
    steam.enable = true;
  };
}
