# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ ... }:

{
  programs.oh-my-posh = {
    enableZshIntegration = true;
    configFile = ./config.yml;
    enable = true;
  };
}
