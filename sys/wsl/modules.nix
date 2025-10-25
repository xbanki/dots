#   WSL specific package configuration.
#
# Configures a basic headless development environment.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ config, ... }:

let
  args = { inherit config; };

  imports = [
    ./../../mod/oh-my-posh
    ./../../mod/ssh.nix
    ./../../mod/zsh.nix
  ];
in
{
  home-manager.users.${config.user.name}.imports = builtins.map
    (module: import module args)
    imports;
}
