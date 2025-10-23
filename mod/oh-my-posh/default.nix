#   Oh My Posh configuration.
#
# Actual theme configuration can be found in adjacent conmfig file `theme.yml`.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ self, ... }:

{
  programs.oh-my-posh = {
    enableZshIntegration = true;
    configFile = ./theme.yml;
    enable = true;
  };
}
