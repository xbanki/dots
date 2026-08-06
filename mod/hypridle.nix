# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch hl.dsp.dpms({ action = \"enable\" })";
        before_sleep_cmd = "loginctl lock-session";
        lock_cmd = "pidof hyprlock || hyprlock";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
          on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
          timeout = 180;
        }
        {
          on-timeout = "loginctl lock-session";
          timeout = 600;
        }
        {
          condition_cmd = "suspend-inhibited";
          on-timeout = "systemctl suspend";
          timeout = 900;
        }
      ];
    };
  };
}
