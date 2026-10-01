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
{
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
