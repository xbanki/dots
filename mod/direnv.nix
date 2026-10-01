# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, pkgs, ... }:

let
  home =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "/Users/${props.user.name}"
    else
      "/home/${props.user.name}";

in
{
  programs.direnv = {
    config = {
      global = {
        disable_stdin = true;
        hide_env_diff = true;
        log_filter = "^$";
      };

      whitelist.prefix = [
        "${home}/Workspace"
        "${home}/workspace"
      ];
    };

    nix-direnv.enable = true;
    enable = true;
  };
}
