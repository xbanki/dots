#   Git configuration
#
# Very basic git configuration. Does not set any advanced properties.
#
#   Copyright: Banki <contact@xbanki.me>
#              Licensed under the MIT License.
#              See LICENSE for details.

{ props, pkgs, ... }:

with props;
{
  home.packages = with pkgs; [
    git-lfs
  ];

  programs.git = {
    settings = {
      init.defaultBranch = git.mainbranch;
      user = {
        email = git.email;
        name = git.name;
      };
    };

    enable = true;
  };
}
