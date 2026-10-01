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
  programs.gpg = {
    homedir = "${home}/.config/gnupg";
    enable = true;
  };
}
