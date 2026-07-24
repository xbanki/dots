# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  system,
  inputs,
  props,
  pkgs,
  ...
}:

let
  portalPackage = inputs.nixpkgs-hyprland.packages.${system}.xdg-desktop-portal-hyprland;
  package = inputs.nixpkgs-hyprland.packages.${system}.hyprland;

in
{
  # FIXME: (xbanki) Remove `hyprlauncher` once we have our shell built.
  home.packages = with pkgs; [
    hyprlauncher
    wl-clipboard
    xrandr
    slurp
    grim
  ];

  xdg = {
    configFile = {
      "hypr/config.lua" = with props; {
        text = ''
          local M = {}

          M.MOUSE = {
            ACCELERATION_PROFILE = "${os.mouse.accelerationprofile}",
            SENSITIVITY = ${os.mouse.sensitivity},
          }

          M.KEYBOARD = {
            LAYOUT = "${os.keyboard.layout}",
            OPTIONS = "",
            VARIANT = "",
          }

          M.SOFTWARE = {
            LAUNCHER = "hyprlauncher",
            EXPLORER = "dolphin",
            TERMINAL = "ghostty",
          }

          M.MONITOR_PRIMARY = "${os.primarymonitor}"
          M.USERNAME = "${user.name}"

          return M
        '';

        enable = true;
      };

      hypr = {
        source = ./config;
        recursive = true;
      };
    };
  };

  wayland.windowManager.hyprland = {
    plugins = with inputs.nixpkgs-hyprland-plugins.packages.${system}; [
      csgo-vulkan-fix
      hyprbars
    ];

    extraConfig = builtins.readFile ./shim.lua;
    inherit portalPackage package;
    systemd.enable = false;
    configType = "lua";
    enable = true;
  };
}
