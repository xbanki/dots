#   Home Manager configuration
#
# Automatically applies user settings defined in `local.config.toml`, which
# overrides `config.toml`. Installed packages depend on the target system
# configuration.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ nixpkgs, modules, version, config, ... }:

let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  base = with config; {
    programs.zsh.enable = true;
    users = {
      users.${user.name} = {
        extraGroups = user.groups;
        isNormalUser = true;
        shell = pkgs.zsh;
      };
    };

    home-manager = {
      users.${user.name} = {
        programs.home-manager.enable = true;
        home = {
          homeDirectory = nixpkgs.lib.mkForce user.path;
          shell.enableZshIntegration = true;
          stateVersion = version;
          username = user.name;
        };
      };

      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
in
  nixpkgs.lib.recursiveUpdate base modules
