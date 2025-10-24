#   SSH configuration
#
# Configures `~/.ssh/config` file, SSH keys defined in `config.toml`.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ config, ... }:

let

in
  {
    programs.zsh = {
      enable = true;
    };
  }
