# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  programs.ghostty = {
    settings.theme = "dark:Nightfox,light:Dayfox";
    enableZshIntegration = true;
    systemd.enable = true;
    enable = true;
  };
}
