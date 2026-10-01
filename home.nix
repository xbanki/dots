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
  home =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "/Users/${props.user.name}"
    else
      "/home/${props.user.name}";

in
with props;
{
  programs.zsh.enable = true;
  users.users.${user.name} = {
    inherit home;
    shell = pkgs.zsh;
  };

  home-manager = {
    users.${user.name} = {
      programs.home-manager.enable = true;
      home = {
        shell.enableZshIntegration = true;
        stateVersion = version;
        homeDirectory = home;
        username = user.name;
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
