# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, ... }:

with props;
let
  hosts = builtins.listToAttrs (
    builtins.map (h: {
      value = builtins.removeAttrs h [ "identifier" ];
      name = h.identifier;
    }) ssh.hosts
  );

in
{
  programs.ssh = {
    enableDefaultConfig = false;
    settings = hosts;
    enable = true;
  };
}
