# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  system,
  inputs,
  props,
  pkgs,
  lib,
  ...
}:

let
  hyprland = inputs.nixpkgs-hyprland.packages.${system}.hyprland;
  config = "greetd/regreet-hyprland-config.lua";

in
with props;
{
  environment = {
    systemPackages = [ hyprland ];
    etc.${config}.text = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("${lib.getExe pkgs.regreet}; hyprctl dispatch 'hl.dsp.exit()'")
      end)

      hl.monitor({ output = "", disabled = true, })
      hl.monitor({
        output = "desc:${os.primarymonitor}",
        mode = "preferred",
        disabled = false,
        position = "0x0",
        scale = 1,
      })

      hl.config({
        input = {
          accel_profile = ${os.mouse.accelerationprofile},
          sensitivity = ${os.mouse.sensitivity},
          kb_layout = ${os.keyboard.layout},
        },

        misc = {
          disable_hyprland_guiutils_check = true,
          disable_splash_rendering = true,
          disable_hyprland_logo = true,
        },
      })
    '';
  };

  programs.regreet.enable = true;
  services.greetd = {
    settings.default_session = {
      command = "${pkgs.dbus}/bin/dbus-run-session ${hyprland}/bin/start-hyprland -- -c /etc/${config}";
      user = "greeter";
    };

    enable = true;
  };
}
