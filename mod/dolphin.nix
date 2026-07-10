# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, pkgs, ... }:

{
  home-manager.users.${props.user.name}.xdg = {
    portal.config.hyprland."org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
    mimeApps.defaultApplications."inode/directory" = "org.kde.dolphin.desktop";
  };

  environment.systemPackages = builtins.concatLists [
    (with pkgs.kdePackages; [
      qtdeclarative
      kio-extras
      kio-fuse
      dolphin
      qtsvg
      kio
      ark
    ])

    (with pkgs; [
      unrar-free
      unzip
      zip
    ])
  ];
}
