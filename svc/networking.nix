# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [
    libimobiledevice
  ];

  networking.networkmanager.enable = true;
}
