# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ flatpaks, ... }:

{
  services.flatpak = {
    remotes = [
      {
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        name = "flathub";
      }
    ];

    packages = flatpaks;
    enable = true;
  };
}
