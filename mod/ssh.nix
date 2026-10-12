# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, pkgs, ... }:

with props;
let
  hosts = builtins.listToAttrs (
    builtins.map
      (h: {
        value = builtins.removeAttrs h [ "identifier" ];
        name = h.identifier;
      })
      (
        ssh.hosts
        ++ [
          (
            {
              AddKeysToAgent = "yes";
              identifier = "*";
            }
            // pkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
              UseKeychain = true;
            }
          )
        ]
      )
  );

in
{
  programs.ssh = {
    enableDefaultConfig = false;
    settings = hosts;
    enable = true;
  };
}
