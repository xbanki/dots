# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  version,
  inputs,
  props,
  ...
}:

let
  pkgs = import inputs.nixpkgs { inherit system; };
  system = "x86_64-linux";
  specialArgs = {
    inherit
      version
      inputs
      system
      props
      ;
  };

in
with inputs;
nixpkgs.lib.nixosSystem {
  inherit specialArgs system;
  modules =
    with props;
    pkgs.lib.flatten [
      ./boot.nix
      ./home.nix
      ./hardware.nix
      ./../../home.nix
      nixpkgs-home-manager.nixosModules.home-manager
      {
        system.stateVersion = version;
        nixpkgs.config = {
          allowUnfreePredicate = _: true;
          allowUnfree = true;
        };

        networking = {
          networkmanager.enable = true;
          hostName = os.hostname;
        };

        environment.sessionVariables = rec {
          GTK_IM_MODULE = INPUT_METHOD;
          QT_IM_MODULE = INPUT_METHOD;
          INPUT_METHOD = "fcitx5";
        };

        i18n.inputMethod = {
          fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
              kdePackages.fcitx5-qt
              fcitx5-gtk
            ];
          };

          type = "fcitx5";
          enable = true;
        };

        security.rtkit.enable = true;
        time.timeZone = os.timezone;
      }

      (builtins.map (m: ../../svc + "/${m}") [
        "virtualisation.nix"
        "hyprland.nix"
        "pipewire.nix"
        "flatpak.nix"
        "greetd.nix"
        "gpg.nix"
      ])
    ];
}
