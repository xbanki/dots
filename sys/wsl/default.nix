#   WSL System Configuration
#
# Lightweight Windows development environment, enabling us to escape the hell
# that is Windows instability, spyware and general bloat.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ version, inputs, props, ... }:

let
  system = "x86_64-linux";
  args = { inherit props; };
  specialArgs =
    { inherit modules version inputs system props; };
  
  modules = builtins.map
    (m: import m args)
    [
      ./../../mod/oh-my-posh
      ./../../mod/ssh.nix
      ./../../mod/zsh.nix
    ];

  secrets = with props; builtins.listToAttrs (
    builtins.map (
      key: {
        value = {
	  mode = if key.public
	    then "0644"
	    else "0600";

          path = "${user.path}/.ssh/${key.name}";
          sopsFile = ./../../${key.path};
	  owner = user.name;
          format = "yaml";
          key = "data";
	};

        name = key.name;
      }
    )

    ssh.keys
  );

in with inputs; nixpkgs.lib.nixosSystem {
  system = system; 
  specialArgs = specialArgs;
  modules = with props; [
    ./../../home.nix
    nixpkgs-sops.nixosModules.sops
    nixpkgs-wsl.nixosModules.default
    nixpkgs-home-manager.nixosModules.home-manager
    {
      system.stateVersion = version;
      sops = {
        age.keyFile = user.sopskey;
	defaultSopsFormat = "yaml";
        secrets = secrets;
      };

      wsl = {
        wslConf = {
          interop.appendWindowsPath = false;
          automount.root = "/mnt";
        };

        defaultUser = user.name;
        enable = true;
      };
    }
  ];
}
