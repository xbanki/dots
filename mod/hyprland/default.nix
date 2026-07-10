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
  home.packages = with pkgs; [ hyprlauncher ];

  xdg = {
    configFile = {
      "hypr/config.lua" = with props; {
        text = ''
          local M = {}

          M.MOUSE = {
            ACCELERATION_PROFILE = "flat",
            SENSITIVITY = 0,
          }

          M.KEYBOARD = {
            LAYOUT = "${os.layout}",
            OPTIONS = "",
            VARIANT = "",
          }

          M.SOFTWARE = {
            LAUNCHER = "hyprlauncher",
            EXPLORER = "dolphin",
            TERMINAL = "ghostty",
          }

          M.MONITOR_PRIMARY = "Lenovo Group Limited R25f-30 URW12Z0R"
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

    portal = {
      enable = true;
      config.hyprland.default = [
        "hyprland"
        "gtk"
      ];

      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
    };
  };

  wayland.windowManager.hyprland = {
    plugins = with inputs.nixpkgs-hyprland-plugins.packages.${system}; [
      csgo-vulkan-fix
      hyprbars
    ];

    extraConfig = builtins.readFile ./shim.lua;
    systemd.variables = [ "--all" ];
    inherit portalPackage package;
    xwayland.enable = true;
    configType = "lua";
    enable = true;
  };
}
