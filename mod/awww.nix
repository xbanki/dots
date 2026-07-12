# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  system,
  config,
  inputs,
  ...
}:

{
  home.file =
    with builtins;
    listToAttrs (
      map
        (wallpaper: {
          name = "${config.xdg.userDirs.pictures}/Wallpapers/${wallpaper}";
          value.source = ../img + "/${wallpaper}";
        })
        [
          "wallpaper-light.jpg"
          "wallpaper-dark.jpg"
        ]
    );

  services.awww = {
    package = inputs.nixpkgs-awww.packages.${system}.awww;
    enable = true;
  };
}
