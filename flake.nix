# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  description = "Banki (xbanki) Dotfiles";
  inputs = {
    nixpkgs-home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    let
      version = "26.05";
      props = {

        # Local user settings.
        user = rec {

          # User home directory path.
          home = "/home/${name}";

          # Groups that the user should belong in. Not applied on MacOS.
          groups = [ "wheel" ];

          # Local user name.
          name = "xbanki";
        };

        # System settings, which only apply to standalone NixOS (`#os`).
        os = {

          # Local system timezone.
          timezone = "Europe/Helsinki";

          # System name, as it appears on the network.
          hostname = "Banki-NIX";

          # System language.
          locale = "en_US.UTF-8";

          # System keyboard layout.
          layout = "fi";
        };

        # Git configuration.
        git = {

          # Git user name.
          name = "xbanki";

          # Git user email.
          email = "development@xbanki.me";

          # Main branch name.
          branch = "main";
        };

        # SSH host settings, which allows us to attach SSH keys to domains.
        ssh.hosts = [
          {
            identityFile = "~/.ssh/id_ed25519_xbanki";
            identifier = "xbanki.github.com";
            hostname = "github.com";
            user = "git";
          }
        ];
      };

    in
    {
      nixosConfigurations = {
        os = import ./sys/os { inherit version inputs props; };
      };
    };
}
