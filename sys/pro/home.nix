# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  inputs,
  system,
  props,
  ...
}:

let
  pkgs = import inputs.nixpkgs { inherit system; };
  extraSpecialArgs = {
    inherit
      inputs
      system
      props
      pkgs
      ;
  };

in
with props;
rec {
  system.primaryUser = user.name;
  nix-homebrew = {
    taps = with inputs; {
      "homebrew/homebrew-core" = nixpkgs-homebrew-core;
      "homebrew/homebrew-cask" = nixpkgs-homebrew-cask;
    };

    user = props.user.name;
    mutableTaps = false;
    enable = true;
  };

  homebrew = {
    taps = builtins.attrNames nix-homebrew.taps;
    enable = true;
    casks = [
      "ghostty"
    ];
  };

  home-manager = {
    inherit extraSpecialArgs;
    users.${user.name}.imports =
      with inputs;
      pkgs.lib.flatten [
        ./../../svc/gpg.nix
        nixpkgs-nixvim.homeModules.nixvim
        (builtins.map (m: ../../mod + "/${m}") [
          "fastfetch.nix"
          "direnv.nix"
          "oh-my-posh"
          "git.nix"
          "gpg.nix"
          "ssh.nix"
          "zsh.nix"
          "neovim"
        ])
      ];
  };
}
