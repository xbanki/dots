#   Home Manager configuration
#
# Automatically applies user settings defined in `local.config.toml`, which
# overrides `config.toml`. Installed packages depend on the target system
# configuration.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ inputs, modules, version, config, ... }:

let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  nixpkgs = inputs.nixpkgs;
  secrets = with config; builtins.listToAttrs (
    builtins.map (
      key: {
        value = {
	  mode = if key.public
	    then "0644"
	    else "0600";

          path = "${user.path}/.ssh/${key.name}";
          sopsFile = ./${key.path};
          format = "yaml";
          key = "data";
	};

        name = key.name;
      }
    )
    ssh.keys
  );

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
      sharedModules = [
        inputs.nixpkgs-sops.homeManagerModules.sops
      ];

      users.${user.name} = {
        programs.home-manager.enable = true;
        sops = {
          age.keyFile = config.user.sopskey;
	  secrets = secrets;
        };

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
