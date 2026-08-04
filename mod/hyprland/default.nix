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
      "uwsm/env-hyprland".text = ''
        export GDK_BACKEND                  = "wayland,x11,*"
        export QT_QPA_PLATFORM              = "wayland;xcb"
        export XDG_SESSION_DESKTOP          = "Hyprland"
        export XDG_CURRENT_DESKTOP          = "Hyprland"
        export ELECTRON_OZONE_PLATFORM_HINT = "wayland"
        export XDG_SESSION_TYPE             = "wayland"
        export OZONE_PLATFORM               = "wayland"
        export MOZ_ENABLE_WAYLAND           = "1"
      '';

      "uwsm/env".text = ''
        export __GLX_VENDOR_LIBRARY_NAME    = "nvidia"
        export LIBVA_DRIVER_NAME            = "nvidia"
        export WLR_NO_HARDWARE_CURSORS      = "1"
        export WLR_DRM_NO_ATOMIC            = "1"
      '';

      "hypr/config.lua".text = with props; ''
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
