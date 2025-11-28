#   Z Shell configuration
#
# Enables the usage of Z Shell (zsh) in the home configuration.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ ... }:

{
  programs.zsh = {
    localVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      mkdir = "mkdir -pv";
      cp = "cp -irv";
      ls = "ls -AlU";
      rm = "rm -fir";
      mv = "mv -iv";
    };

    history.append = true;
    enable = true;
    autocd = true;
  };
}
