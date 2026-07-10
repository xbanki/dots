# Copyright: Banki <development@xbanki.me>
#            Licensed under the MIT License.
#            See LICENSE for details.

{ props, pkgs, ... }:

with props;
{
  home.packages = with pkgs; [
    git-lfs
  ];

  programs.git = {
    settings = {
      init.defaultBranch = git.branch;
      user = {
        email = git.email;
        name = git.name;
      };
    };

    enable = true;
  };
}
