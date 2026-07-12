# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{
  version,
  inputs,
  system,
  props,
  ...
}:

let
  pkgs = import inputs.nixpkgs { inherit system; };

in
with props;
{
  programs.zsh.enable = true;
  users.users.${user.name} = {
    home = user.home;
    shell = pkgs.zsh;
  };

  home-manager = {
    users.${user.name} = {
      programs.home-manager.enable = true;
      home = {
        shell.enableZshIntegration = true;
        homeDirectory = user.home;
        stateVersion = version;
        username = user.name;
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
