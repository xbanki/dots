# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  inputs,
  system,
  props,
  ...
}:

let
  pkgs = import inputs.nixpkgs { inherit system; };
  extraSpecialArgs = {
    inherit
      flatpaks
      inputs
      system
      props
      pkgs
      ;
  };

  flatpaks = [
    "com.github.Matoking.protontricks"
    "com.github.tchx84.Flatseal"
    "com.usebottles.bottles"
    "net.davidotek.pupgui2"
    "app.zen_browser.zen"
    "com.spotify.Client"
    "com.adamcake.Bolt"
  ];

in
with props;
{
  environment = {
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];

    sessionVariables.XKB_DEFAULT_LAYOUT = os.layout;
  };

  i18n.defaultLocale = os.locale;
  console.useXkbConfig = true;
  services.xserver = {
    exportConfiguration = true;
    xkb.layout = os.layout;
  };

  users.users.${user.name} = {

    extraGroups = user.groups;
    isNormalUser = true;
  };

  home-manager = {
    inherit extraSpecialArgs;
    users.${user.name} = {
      xdg = {
        mime.enable = true;
        mimeApps.enable = true;
        userDirs = {
          createDirectories = true;
          enable = true;
        };
      };

      imports =
        with inputs;
        pkgs.lib.flatten [
          nixpkgs-nixvim.homeModules.nixvim
          nixpkgs-hyprland.homeManagerModules.default
          nixpkgs-nix-flatpak.homeManagerModules.nix-flatpak
          (builtins.map (m: ../../mod + "/${m}") [
            "flatpak.nix"
            "ghostty.nix"
            "vesktop.nix"
            "hyprland"
            "git.nix"
            "gpg.nix"
            "ssh.nix"
            "zsh.nix"
            "neovim"
          ])
        ];
    };
  };

  imports = builtins.map (m: ../../mod + "/${m}") [
    "dolphin.nix"
  ];
}
