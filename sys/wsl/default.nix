#   WSL System Configuration
#
# Lightweight Windows development environment, enabling us to escape the hell
# that is Windows instability, spyware and general bloat.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{
  version,
  inputs,
  props,
  ...
}:

let
  pkgs = import inputs.nixpkgs { inherit system; };
  args = { inherit props pkgs; };
  system = "x86_64-linux";
  specialArgs = {
    inherit
      modules
      version
      inputs
      system
      props
      ;
  };

  modules = builtins.map (m: import m args) [
    ./../../mod/fastfetch.nix
    ./../../mod/oh-my-posh
    ./../../mod/direnv.nix
    ./../../mod/git.nix
    ./../../mod/ssh.nix
    ./../../mod/zsh.nix
    ./../../mod/neovim
  ];

  secrets =
    with props;
    builtins.listToAttrs (
      builtins.concatLists ([
        [
          {
            value = {
              sopsFile = ./../../${user.password};
              neededForUsers = true;
              key = "data";
            };

            name = "password";
          }
        ]

        (builtins.map
          (key: {
            value = {
              mode = if key.public then "0644" else "0600";

              path = "${user.path}/.ssh/${key.name}";
              sopsFile = ./../../${key.path};
              owner = user.name;
              key = "data";
            };

            name = key.name;
          })

          ssh.keys
        )
      ])
    );

in
with inputs;
nixpkgs.lib.nixosSystem {
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
          interop = {
            appendWindowsPath = true;
            enabled = true;
          };

          automount.root = "/mnt";
        };

        defaultUser = user.name;
        enable = true;
      };
    }
  ];
}
