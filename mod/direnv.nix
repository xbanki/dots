# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, ... }:

with props;
{
  programs.direnv = {
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        log_filter = "^$";
      };

      whitelist.prefix = [
        "${user.home}/Workspace"
        "${user.home}/workspace"
      ];
    };

    nix-direnv.enable = true;
    enable = true;
  };
}
