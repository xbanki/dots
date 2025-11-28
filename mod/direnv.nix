#   Direnv configuration
#
# Direnv is configured to automatically trust any `default.nix` or `shell.nix`
# within `~/Workspace`.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ props, ... }:

{
  programs.direnv = with props; {
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        log_filter = "^$";
      };

      whitelist.prefix = [
        "${user.path}/Workspace"
        "${user.path}/workspace"
      ];
    };

    nix-direnv.enable = true;
    enable = true;
  };
}
