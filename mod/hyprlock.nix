# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, ... }:

with props;
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          monitor = "desc:${os.primarymonitor}";
          placeholder_text = "Password";
          fade_on_empty = false;
          position = "0, -80";
          dots_center = true;
          shadow_passes = 2;
          size = "200, 50";
        }
      ];
    };
  };
}
