# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  system,
  inputs,
  pkgs,
  lib,
  ...
}:

let
  hyprland = inputs.nixpkgs-hyprland.packages.${system}.hyprland;
  config = "greetd/regreet-hyprland-config.lua";

in
{
  environment = {
    systemPackages = [ hyprland ];
    etc.${config}.text = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("${lib.getExe pkgs.regreet}; hyprctl dispatch 'hl.dsp.exit()'")
      end)

      hl.monitor({ output = "", disabled = true, })
      hl.monitor({
        output = "desc:Lenovo Group Limited R25f-30 URW12Z0R",
        mode = "preferred",
        disabled = false,
        position = "0x0",
        scale = 1,
      })

      hl.config({
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
