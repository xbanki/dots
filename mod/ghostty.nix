# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  programs.ghostty = {
    enableZshIntegration = true;
    systemd.enable = true;
    enable = true;
  };
}
