#   NixOS System Configuration
#
# Customized NixOS distribution. Lightweight and minimal by design.
#
#   Copyright: Banki <development@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  version,
  inputs,
  props,
  ...
}:

let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    config = {
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };

    inherit system;
  };

  specialArgs = { inherit system; };

in
with inputs;
nixpkgs.lib.nixosSystem {
  inherit specialArgs system;
  modules = with props; [
    ./boot.nix
    ./hardware.nix
    {
      environment.sessionVariables = rec {
        XKB_DEFAULT_LAYOUT = os.keyboardLayout;
        GTK_IM_MODULE = INPUT_METHOD;
        QT_IM_MODULE = INPUT_METHOD;
        XMODIFIERS = "@im=fcitx";
        INPUT_METHOD = "fcitx5";
      };

      console.useXkbConfig = true;
      i18n = {
        inputMethod = {
          fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
              fcitx5-gtk
            ];
          };

          type = "fcitx5";
          enable = true;
        };

        defaultLocale = os.locale;
      };

      services.xserver = {
        xkb.layout = os.keyboardLayout;
        exportConfiguration = true;
      };

      networking = {
        networkmanager.enable = true;
        hostName = os.hostname;
      };

      time.timeZone = os.timezone;
      system.stateVersion = version;
      nixpkgs.config = {
        allowUnfreePredicate = _: true;
        allowUnfree = true;
      };
    }
  ];
}
