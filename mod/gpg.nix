# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, ... }:

with props;
{
  programs.gpg = {
    homedir = "/home/${user.name}/.config/gnupg";
    enable = true;
  };
}
