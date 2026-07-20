# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.android-tools ];
  virtualisation.libvirtd.enable = true;
}
