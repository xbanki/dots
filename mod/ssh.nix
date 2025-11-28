#   SSH configuration
#
# Configures `~/.ssh/config` file, SSH keys defined in `config.toml`.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ props, ... }:

with props;
let
  hosts = builtins.listToAttrs (
    builtins.map (host: {
      value = builtins.removeAttrs host [ "identifier" ];
      name = host.identifier;
    }) (builtins.filter (host: builtins.isString host.identifier) ssh.hosts)
  );

in
{
  programs.ssh = {
    enableDefaultConfig = false;
    matchBlocks = hosts;
    enable = true;
  };
}
