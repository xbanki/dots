# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ system, inputs, ... }:

let
  pkgs = import inputs.nixpkgs { inherit system; };

in
with pkgs;
if stdenv.hostPlatform.isDarwin then
  {
    services.gpg-agent = {
      pinentry.package = pinentry_mac;
      enable = true;
    };
  }

else
  {
    programs.gnupg.agent = {
      pinentryPackage = pinentry-tty;
      enableBrowserSocket = true;
      enableSSHSupport = true;
      enable = true;
    };
  }
