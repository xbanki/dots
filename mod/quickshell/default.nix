# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  inputs,
  system,
  pkgs,
  ...
}:

{
  home.sessionVariables = {
    QMLLS_BUILD_DIRS = "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml/:${
      inputs.nixpkgs-quickshell.packages.${system}.default
    }/lib/qt-6/qml/";
    QML_IMPORT_PATH = "$PWD/src";
  };

  programs.quickshell = {
    systemd = {
      target = "hyprland-session.target";
      enable = true;
    };

    package = inputs.nixpkgs-quickshell.packages.${system}.default;
    # FIXME: (xbanki) Quickshell config.
    # activeConfig = ./config;
    enable = true;
  };
}
