# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  services.automatic-timezoned.enable = true;
  fileSystems."/usr/share/zoneinfo" = {
    device = "/etc/zoneinfo";
    fsType = "fuse.bindfs";
    options = [
      "ro"
      "x-gvfs-hide"
      "resolve-symlinks"
    ];
  };
}
