#   Home Manager configuration
#
# Automatically applies user settings defined in `local.config.toml`, which
# overrides `config.toml`. Installed packages depend on the target system
# configuration.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ modules, version, inputs, system, config, props, ... }:

let
  pkgs = import inputs.nixpkgs { inherit system; };

in with props; {
  programs.zsh.enable = true;
  users = {
    users.${user.name} = {
      hashedPasswordFile = config.sops.secrets.password.path;
      extraGroups = user.groups;
      isNormalUser = true;
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    users.${user.name} = {
      programs.home-manager.enable = true;
      imports = modules;
      home = {
        homeDirectory = user.path;
        shell.enableZshIntegration = true;
        stateVersion = version;
        username = user.name;
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
