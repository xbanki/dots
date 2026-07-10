# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ pkgs, ... }:

{
  programs.gnupg.agent = {
    pinentryPackage = pkgs.pinentry-tty;
    enableBrowserSocket = true;
    enableSSHSupport = true;
    enable = true;
  };
}
