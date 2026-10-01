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
      commit.gpgsign = true;
      init.defaultBranch = git.branch;
      user = {
        signingkey = git.fingerprint;
        email = git.email;
        name = git.name;
      };
    };

    enable = true;
  };
}
