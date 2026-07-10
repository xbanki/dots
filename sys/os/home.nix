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
  environment.sessionVariables.XKB_DEFAULT_LAYOUT = os.layout;
  i18n.defaultLocale = os.locale;
  console.useXkbConfig = true;
  services.xserver = {
    exportConfiguration = true;
    xkb.layout = os.layout;
  };

  users.users.${user.name} = {

    extraGroups = user.groups;
    isNormalUser = true;
  };

  home-manager = {
    inherit extraSpecialArgs;
    users.${user.name} = {
      xdg = {
        mime.enable = true;
        mimeApps.enable = true;
        userDirs = {
          createDirectories = true;
          enable = true;
        };
      };

      imports =
        with inputs;
        pkgs.lib.flatten [
          nixpkgs-nixvim.homeModules.nixvim
          (builtins.map (m: ../../mod + "/${m}") [
            "git.nix"
            "gpg.nix"
            "ssh.nix"
            "zsh.nix"
            "neovim"
          ])
        ];
    };
  };
}
