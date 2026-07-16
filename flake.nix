# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  description = "Banki (xbanki) Dotfiles";
  inputs = {

    nixpkgs-hyprland-plugins = {
      inputs.hyprland.follows = "nixpkgs-hyprland";
      url = "github:hyprwm/hyprland-plugins/3aa21f2e0ca72412f1b434c3126f8f1fec3c716c";
    };

    nixpkgs-home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/Hyprland/a0136d8c04687bb36eb8a28eb9d1ff92aea99704";
    };

    nixpkgs-nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs-nixcord.url = "github:4evy/nixcord";
    nixpkgs-awww.url = "git+https://codeberg.org/LGFae/awww";
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
          primarymonitor = "Lenovo Group Limited R25f-30 URW12Z0R";

          # System keyboard settings.
          keyboard.layout = "fi";

          # System mouse settings.
          mouse = {

            # Hyprland acceleration profile.
            accelerationprofile = "flat";

            # Hyprland mouse sensitivity. 0 means raw input.
            sensitivity = "0";
          };

          # Local system timezone.
          timezone = "Europe/Helsinki";

          # System name, as it appears on the network.
          hostname = "Banki-NIX";

          # System language.
          locale = "en_US.UTF-8";
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
